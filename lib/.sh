#!/bin/bash

# Fungsi untuk menampilkan pesan kesalahan
error() {
    echo "Error: $1"
    exit 1
}

# Periksa versi Java yang digunakan oleh Visual Studio Code
java_version=$(java -version 2>&1 | awk '/version/ {print $3}')

if [[ "$java_version" =~ "1.8" ]]; then
    echo "Java version 1.8 detected."

    # Tampilkan lokasi JDK 11 atau lebih tinggi jika tersedia
    jdk_path=$(find /usr/lib/jvm -mindepth 1 -maxdepth 1 -type d -name "jdk*" | grep -E "^/usr/lib/jvm/jdk(1[1-9]|[2-9][0-9]+)" | sort -r | head -n 1)
    if [ -z "$jdk_path" ]; then
        error "Java 11 or higher not found."
    else
        echo "Java 11 or higher found at: $jdk_path"
        export JAVA_HOME="$jdk_path"
        echo "JAVA_HOME set to: $JAVA_HOME"
    fi
else
    echo "Java version 11 or higher already in use."
fi
