FROM resin/rpi-raspbian

RUN apt-get update && apt-get install cron -y

RUN mkdir /app
WORKDIR /app
ADD ./cron-job.sh ./cron-job.sh
ADD crontab /etc/cron.d/cron-job
RUN chmod 0644 /etc/cron.d/cron-job

RUN echo "--- restart --- " > /app/cron.log

CMD echo $RESIN_DEVICE_UUID > /app/uuid.txt && cron && tail -f /app/cron.log
