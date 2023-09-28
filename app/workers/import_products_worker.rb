require 'net/http'
require 'zlib'
require 'json/streamer'
require 'benchmark'

class ImportProductsWorker
  include Sidekiq::Worker
  MAX_PRODUCTS = 100

  def perform(url)
    @url = url
    uri = URI(url)
    product_count = 0

    puts 'Iniciando o download e processamento do arquivo...'

    begin
      time = Benchmark.realtime do
        buffer = download_file(uri)

        if buffer
          puts "Buffer size: #{buffer.length} / Expected Content-Length: #{buffer.length}"
          process_buffer(buffer, product_count)
        else
          puts 'Erro: Buffer não recebido.'
        end
      end

      puts "Processamento concluído em #{time} segundos."
    rescue StandardError => e
      Rails.logger.error("Erro ao importar produtos: #{e.message}")
    end
  end

  private

  def download_file(uri)
    buffer = StringIO.new

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri)

      http.request(request) do |response|
        if response.is_a?(Net::HTTPSuccess)
          response.read_body do |chunk|
            buffer.write(chunk)
          end
          return buffer
        else
          puts "Falha ao recuperar o arquivo. Status: #{response.code}"
          return nil
        end
      rescue StandardError => e
        puts "Erro ao recuperar o arquivo: #{e.message}"
        return nil
      end
    end
  end

  def process_buffer(buffer, product_count)
    puts 'Iniciando processamento do buffer...'

    if buffer.string[0..1] != "\x1F\x8B"
      puts 'O conteúdo não está em formato gzip.'
      return
    end

    begin
      gzip_reader = Zlib::GzipReader.new(StringIO.new(buffer.string))

      puts 'Tentando ler os primeiros bytes descomprimidos...'
      gzip_reader.ungetc(gzip_reader.read(10))

      puts 'Processando cada linha...'
      gzip_reader.each_line do |line|
        break if product_count >= MAX_PRODUCTS

        begin
          product_data = JSON.parse(line.strip)
          puts "Produto: #{product_data['code']} processado"
          process_product(product_data)
          product_count += 1
        rescue JSON::ParserError => e
          puts "Erro ao parsear JSON: #{e.message}"
          puts "Linha problemática: #{line[0..100]}..."
        end
      end
    rescue Zlib::GzipFile::Error => e
      puts "Erro ao descomprimir gzip: #{e.message}"
    rescue StandardError => e
      puts "Erro desconhecido: #{e.message}"
    end
  rescue Zlib::GzipFile::Error => e
    puts "Erro: formato gzip não reconhecido - #{e.message}"
  rescue JSON::ParserError => e
    puts "Erro: falha ao analisar JSON - #{e.message}"
  rescue StandardError => e
    puts "Erro desconhecido: #{e.message}"
  end

  def process_product(product_data)
    code = product_data['code'].tr('"', '')
    product_data['code'] = code
    product = Product.find_by(code:)
    attributes = product_data.slice('code', 'status', 'url', 'creator', 'created_t',
                                    'last_modified_t', 'product_name', 'quantity',
                                    'brands', 'categories', 'labels', 'cities', 'purchase_places',
                                    'stores', 'ingredients_text', 'traces', 'serving_size',
                                    'serving_quantity', 'nutriscore_score', 'nutriscore_grade',
                                    'main_category', 'image_url')
    attributes.merge!({
                        status: 'Draft',
                        imported_t: DateTime.now
                      })

    if product
      ProductHistory.create(
        product_code: code,
        imported_t: Time.now,
        status: 'Modified',
        import_sources: @url,
        imported_by: 'automated_script',
        notes: 'atualização de produto',
        product_data: product.attributes
      )
    else
      ProductHistory.create(
        product_code: code,
        imported_t: Time.now,
        status: 'Draft',
        import_sources: @url,
        import_by: 'automated_script',
        notes: 'Criação de produto',
        product_data: attributes
      )

      Product.create(attributes)
    end
  end
end
