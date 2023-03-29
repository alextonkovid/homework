
#!/usr/bin/env python
# coding=utf-8
import pika

#connection = pika.BlockingConnection(pika.ConnectionParameters('192.168.0.25'))
connection = pika.BlockingConnection(
            pika.ConnectionParameters(
                host="192.168.0.25",
                credentials=pika.credentials.PlainCredentials("admin","passwd123"))
        )
channel = connection.channel()
channel.queue_declare(queue='hello')
channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
connection.close()
