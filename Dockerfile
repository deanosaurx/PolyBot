FROM python:3.10.9-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
COPY .telegramToken .telegramToken

RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "bot.py"]