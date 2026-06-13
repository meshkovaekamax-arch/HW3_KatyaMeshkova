## HW3 by Katya Meshkova
**Тематика данных:** Миньоны (обычные или мутировавшие, количество глаз, рост, работают ли на Грю).

## Структура проекта

├── generator/ # генератор CSV-файла
│   ├── generate.py
│   └── Dockerfile
├── report_creator/ # генератор HTML-отчёта
│   ├── report.js
│   ├── package.json
│   └── Dockerfile
├── data/ # папка для CSV и HTML (создаётся автоматически)
├── local_data/  # для локальной откладки генератора данных
├── run.sh # основной скрипт
└── README.md

