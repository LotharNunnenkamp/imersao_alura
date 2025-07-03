# Usa uma imagem Python oficial e leve como base
FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner para /app
WORKDIR /app

# Copia o arquivo de dependências (requirements.txt) para o contêiner
# Este passo é feito separadamente para aproveitar o cache do Docker.
COPY requirements.txt .

# Instala as dependências listadas no requirements.txt
# A flag --no-cache-dir reduz o tamanho final da imagem, evita cache do pip.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todos os outros arquivos do projeto para o diretório de trabalho no contêiner
COPY . .

# Expõe a porta em que a aplicação será executada.
# Altere 8000 para a porta que sua aplicação utiliza.
EXPOSE 8000

# Define o comando padrão para iniciar a aplicação quando o contêiner for executado.
# Comando para rodar a aplicação usando uvicorn
# O host 0.0.0.0 permite que a aplicação seja acessível externamente ao container
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
