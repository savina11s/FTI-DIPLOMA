FROM eclipse-temurin:17-jdk

WORKDIR /app

RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -fsSL https://tailscale.com/install.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x mvnw
RUN chmod +x start.sh

RUN ./mvnw clean package -DskipTests

EXPOSE 10000

CMD ["./start.sh"]