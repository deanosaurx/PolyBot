FROM python:3.9.16-slim
WORKDIR /app

COPY requirements.txt requirements.txt
COPY .telegramToken .telegramToken

RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "bot.py"]