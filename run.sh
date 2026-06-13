#!/bin/bash
set -e

show_help() {
    echo "Использование: ./run.sh [команда]"
    echo ""
    echo "Доступные команды:"
    echo "build_generator   - собирается образ для контейнера генератора "
    echo "run_generator     - запускается контейнер, который генерирует data/data.csv локально"
    echo "create_local_data - в директории local_data создается data.csv (для локальной отладки)"
    echo "build_reporter - собирает образ для контейнера аналитика"
    echo "run_reporter - запускается контейнер, который генерирует html отчет локально в директории data"
    echo "structure - вывод структуры всех файлов и директорий проекта начиная с текущей папки"
    echo "clear_data - удаление всех сгенерированных данных — файлы `.csv` и `.html` из папки `data/`"
    echo "inside_generator - запускается контейнер generator и выводится содержимое data изнутри контейнера"
    echo "inside_reporter - проверяется, что контейнер reporter видит файлы data с хоста"
    exit 1
}

case "$1" in

    build_generator)
        echo "=== Сборка Docker-образа для контейнера генератора==="
        docker build -t generator ./generator
        ;;

    run_generator)
        echo "=== Запуск контейнера в Docker локально ==="
        mkdir -p data
        docker run --rm -v "$(pwd)/data:/data" generator
        echo "=== Файл сохранен в data/data.csv! ==="
        ;;

    create_local_data)
        echo "=== Локальное создание data.csv в local_data ==="
        mkdir -p local_data
        docker run --rm -v "$(pwd)/local_data:/data" generator
        echo "=== Файл сохранен в local_data/data.csv! ==="
        ;;
    
    build_reporter)
        echo "=== Создание образа для контейнера аналитика ==="
        docker build -t reporter ./report_creator
        ;;
    
    run_reporter)
        echo "=== Запуск контейнера-аналитика и генерация html отчета в data ==="
        docker run --rm -v "$(pwd)/data:/data" reporter
        ;;
    
    structure)
        echo "=== Структура проекта ==="
        find . -type f -o -type d | sort
    ;;

    clear_data) 
        echo "=== Запущено удаление всех сгенерированных данных ==="
        rm -f data/*.csv data/*.html
        echo "=== Папка data очищена! ==="
    ;;

    inside_generator)
        echo "=== Запуск контейнера generator и вывод содержимого data ==="
        docker run --rm -v "$(pwd)/data:/data" generator ls -la /data
    ;;

    inside_reporter)
        echo "=== Запуск контейнера reporter и вывод содержимого data ==="
        docker run --rm -v "$(pwd)/data:/data" reporter ls -la /data
    ;;
    
    *) 
        echo "Ошибка: Неизвестная команда '$1'"
        show_help
        ;;
esac
