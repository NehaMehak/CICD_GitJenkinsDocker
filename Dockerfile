FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt install nodejs wget -y
RUN node -v
