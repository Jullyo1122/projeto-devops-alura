# 1. Define a imagem base a partir do repositório oficial do Python.
# Usamos a versão 'alpine' por ser mais leve.
FROM python:3.12.11-alpine3.22

# 2. Define o diretório de trabalho dentro do container.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# 3. Copia o arquivo de dependências para o diretório de trabalho.
# Fazemos isso em um passo separado para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker reutilizará a camada de instalação das dependências.
COPY requirements.txt .

# 4. Instala as dependências do projeto.
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# 6. Comando para iniciar a aplicação quando o container for executado.
# Usamos uvicorn para rodar a aplicação FastAPI.
# '--host 0.0.0.0' torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]