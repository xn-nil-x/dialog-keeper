#!/usr/bin/env python3
"""
Dialog Keeper - Main Entry Point

Запуск Telegram бота и всех связанных сервисов.
"""

import asyncio
import logging
import sys
from pathlib import Path

# Добавляем корневую директорию в PYTHONPATH
ROOT_DIR = Path(__file__).parent.parent
sys.path.insert(0, str(ROOT_DIR))

from dotenv import load_dotenv
import os

# Загружаем переменные окружения
load_dotenv()

# Настройка логирования
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('logs/dialog_keeper.log', mode='a')
    ]
)

logger = logging.getLogger(__name__)


async def main():
    """Главная функция запуска бота."""
    logger.info("Starting Dialog Keeper bot...")
    
    # Проверяем наличие необходимых переменных окружения
    required_env_vars = [
        'TELEGRAM_BOT_TOKEN',
        'OPENAI_API_KEY',
    ]
    
    missing_vars = [var for var in required_env_vars if not os.getenv(var)]
    if missing_vars:
        logger.error(f"Missing required environment variables: {', '.join(missing_vars)}")
        logger.error("Please create .env file from .env.example and fill in the required values.")
        sys.exit(1)
    
    try:
        # TODO: Импортировать и запустить bot
        # from src.bot.telegram_bot import run_bot
        # await run_bot()
        
        logger.info("Bot is ready and running!")
        logger.info("Press Ctrl+C to stop.")
        
        # Заглушка для демонстрации
        await asyncio.Event().wait()
        
    except KeyboardInterrupt:
        logger.info("Bot stopped by user.")
    except Exception as e:
        logger.exception(f"Fatal error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        logger.info("Shutting down...")

