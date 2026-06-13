#!/bin/bash
set -e

show_help() {
    echo "Использование: ./run.sh [команда]"
    echo ""
    echo "Доступные команды:"
    echo "build_generator   - собрать образ для контейнера генератора "
    echo "run_generator     - запустить контейнер, который сгенерирует data/data.csv локально"
    echo "create_local_data - в директории local_data создает data.csv (для локальной отладки)"
    echo "build_reporter - собрать образ для контейнера аналитика"
    echo "run_reporter - запустить контейнер, который сгенерирует html отчет локально в директории data"
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
        echo "=== Запуск контейнера и генерация html отчета в data ==="
        docker run --rm -v "$(pwd)/data:/data" reporter
        ;;

    *) 
        echo "Ошибка: Неизвестная команда '$1'"
        show_help
        ;;
esac
