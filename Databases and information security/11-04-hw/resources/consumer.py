#!/usr/bin/env python

#!/usr/bin/env python
# coding=utf-8
import pika

#connection = pika.BlockingConnection(pika.ConnectionParameters('localhost'))
connection = pika.BlockingConnection(
            pika.ConnectionParameters(
                host="192.168.0.25",
                credentials=pika.credentials.PlainCredentials("admin","passwd123"))
        )

channel = connection.channel()
channel.queue_declare(queue='hello')


def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume('hello', callback, auto_ack=True)
channel.start_consuming()

