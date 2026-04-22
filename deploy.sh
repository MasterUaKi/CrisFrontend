#!/bin/bash
# Версия: 1.0.0
# Дата выпуска: 2026-04-21

# RU: Основная директория проекта
# DE: Hauptverzeichnis des Projekts
ROOT_DIR="/home/oriabtsev/dspace-cris-angular-base"

# RU: Имя приложения в PM2
# DE: Anwendungsname in PM2
PM2_APP_NAME="dspace-ui-base"

echo "🚀 RU: Начинаю прямую сборку релиза в папке: $ROOT_DIR"
echo "🚀 DE: Starte direkten Release-Build im Ordner: $ROOT_DIR"

# RU: Переходим в директорию проекта, иначе прерываем выполнение
# DE: Wechsle ins Projektverzeichnis, andernfalls Ausführung abbrechen
cd "$ROOT_DIR" || { 
    echo "❌ RU: Ошибка: директория $ROOT_DIR не найдена!"
    echo "❌ DE: Fehler: Verzeichnis $ROOT_DIR nicht gefunden!"
    exit 1
}

# RU: Установка зависимостей (раскомментируйте, если требуется автоматическое обновление пакетов)
# DE: Abhängigkeiten installieren (auskommentieren, falls automatische Paketaktualisierung erforderlich ist)
# yarn install

# RU: Сборка проекта
# DE: Projekt kompilieren
echo "📦 RU: Компиляция проекта..."
echo "📦 DE: Projekt wird kompiliert..."
NODE_OPTIONS="--max-old-space-size=8196" yarn build:prod

# RU: Проверка успешности компиляции
# DE: Prüfung auf erfolgreiche Kompilierung
if [ $? -ne 0 ]; then
    echo "❌ RU: Ошибка компиляции! Деплой отменен. Сайт работает на старой сборке."
    echo "❌ DE: Kompilierungsfehler! Deployment abgebrochen. Die Website läuft auf dem alten Build."
    exit 1
fi

# RU: Перезапуск приложения в PM2 (для одного экземпляра используем restart)
# DE: Neustart der Anwendung in PM2 (für eine einzelne Instanz verwenden wir restart)
echo "♻️ RU: PM2 Restart: перезапуск приложения $PM2_APP_NAME..."
echo "♻️ DE: PM2 Restart: Neustart der Anwendung $PM2_APP_NAME..."
pm2 restart "$PM2_APP_NAME"

echo "✅ RU: Деплой успешно завершен!"
echo "✅ DE: Deployment erfolgreich abgeschlossen!"