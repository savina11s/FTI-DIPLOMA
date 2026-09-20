FROM eclipse-temurin:17-jdk

WORKDIR /app

# Install Tailscale
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -fsSL https://tailscale.com/install.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . .

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

EXPOSE 8080

CMD ["sh", "-c", "tailscaled --tun=userspace-networking --socks5-server=127.0.0.1:1055 & sleep 5; tailscale up --auth-key=$TS_AUTHKEY; sleep 5; ALL_PROXY=socks5://127.0.0.1:1055/ java -Doracle.net.socksProxyHost=127.0.0.1 -Doracle.net.socksProxyPort=1055 -Doracle.net.socksRemoteDNS=true -jar target/*.jar"]