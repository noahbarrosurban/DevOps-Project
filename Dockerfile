# Etapa 1: Escolher uma imagem base oficial do Python.
# A versão 'slim' é uma ótima escolha para manter a imagem pequena.
FROM python:3.13.4-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. As dependências só serão reinstaladas se o requirements.txt mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# Usar --no-cache-dir ajuda a manter o tamanho da imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação.
# Usamos "0.0.0.0" para que o servidor seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]