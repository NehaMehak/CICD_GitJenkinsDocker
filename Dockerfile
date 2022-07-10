FROM ubuntu:latest
RUN apt update && apt upgrade -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip -y 
RUN mkdir /app
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=5000"]
