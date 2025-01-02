FROM ubuntu:latest

RUN apt-get update && apt-get install -y --no-install-recommends \
    wkhtmltopdf \
    fonts-dejavu-core \
    fonts-liberation \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["wkhtmltopdf"]
CMD ["--help"]
