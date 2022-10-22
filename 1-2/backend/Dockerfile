#stage one to copy and installing packages
FROM python:3.8 AS builder
COPY requirements.txt .

RUN pip install --user -r requirements.txt

#stage two to building and start the command
FROM python:3.8-slim
WORKDIR /app

COPY --from=builder /root/.local /root/.local
COPY . .

EXPOSE 8080
ENV PATH=/root/.local:$PATH

CMD [ "python", "app.py" ]