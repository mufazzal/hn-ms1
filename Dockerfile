FROM node:alpine

RUN apk --no-cache add curl

RUN echo Building Docker image

RUN mkdir -p /usr/src/apps/hn-ms-1

WORKDIR /usr/src/apps/hn-ms-1

COPY . .

EXPOSE 3050

CMD ["npm", "run", "start"]


# docker build -t mufazzal/hn-ms1:latest -t mufazzal/hn-ms1:v1.0.0 .
# docker run -it -p 80:3050 mufazzal/hn-ms1:latest
# docker push mufazzal/hn-ms1:latest