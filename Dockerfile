# Use uma imagem oficial do Ruby
FROM ruby:3.2.2

# Instale dependências
RUN apt-get update -qq && apt-get install -y nodejs

# Defina o diretório de trabalho dentro do container
WORKDIR /importer

# Copie o Gemfile e o Gemfile.lock e instale as gems
COPY Gemfile* ./
RUN bundle install

# Copie o código do aplicativo para o diretório de trabalho
COPY . .

# Exponha a porta em que o aplicativo será executado
EXPOSE 3000

# Inicie o servidor Puma
CMD ["rails", "server", "-b", "0.0.0.0"]
