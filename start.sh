#!/bin/bash

# 1. Jalankan Rasa Action Server di background
echo "Membuka Rasa Action Server di port 5055..."
python -m rasa_sdk --actions actions --port 5055 &

# 2. Tunggu beberapa detik agar SDK siap
sleep 3

# 3. Jalankan Rasa Core Utama di foreground
echo "Membuka Rasa Core di port $PORT..."
exec rasa run --enable-api --cors "*" --credentials credentials.yml --endpoints endpoints.yml --port $PORT