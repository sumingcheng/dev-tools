import os
import subprocess
import sqlite3
from glob import glob

from logger.logger_config import logger


class Config:
    DATABASE_PATH = "file_process.db"
    MARKDOWN_DIR = "markdown"


def create_db():
    try:
        with sqlite3.connect(Config.DATABASE_PATH) as conn:
            cursor = conn.cursor()
            cursor.execute(
                "CREATE TABLE IF NOT EXISTS processed_files (filename TEXT PRIMARY KEY)"
            )
            conn.commit()
    except Exception as e:
        logger.error(f"创建或连接数据库时出错: {e}")


def db_operation(sql, params=None):
    try:
        with sqlite3.connect(Config.DATABASE_PATH) as conn:
            cursor = conn.cursor()
            cursor.execute(sql, params or [])
            result = cursor.fetchall() if "SELECT" in sql else conn.commit()
            return result
    except Exception as e:
        logger.error(f"数据库操作错误: {e}")
        return None


def record_file(filename):
    db_operation(
        "INSERT OR IGNORE INTO processed_files (filename) VALUES (?)", (filename,)
    )


def is_processed(filename):
    return (
            db_operation(
                "SELECT filename FROM processed_files WHERE filename = ?", (filename,)
            )
            != []
    )


def process_files(directory, extension, conversion_func):
    files = glob(os.path.join(directory, f"*.{extension}"))
    processed, skipped = 0, 0
    markdown_dir = os.path.join(os.path.dirname(directory), Config.MARKDOWN_DIR)
    os.makedirs(markdown_dir, exist_ok=True)

    for file in files:
        if not is_processed(file):
            try:
                output_file = os.path.join(
                    markdown_dir, os.path.basename(file).rsplit(".", 1)[0] + ".md"
                )
                subprocess.run(conversion_func(file, output_file), check=True)
                record_file(file)
                processed += 1
            except subprocess.CalledProcessError as e:
                logger.error(f"文件处理失败 {file}: {e}")
            except Exception as e:
                logger.error(f"文件处理中发生异常 {file}: {e}")
        else:
            skipped += 1

    logger.info(f"{extension.upper()}: 已处理 {processed} 个, 跳过 {skipped} 个")


def command_for_file(file, output_file, file_type=None):
    if file_type == "xlsx":
        csv_file = file.rsplit(".", 1)[0] + ".csv"
        subprocess.run(["xlsx2csv", file, csv_file], check=True)
        return ["pandoc", csv_file, "-t", "markdown", "-o", output_file]
    else:
        return ["pandoc", file, "-t", "markdown", "-o", output_file]


def main():
    create_db()
    base_dir = os.getcwd()

    process_files(
        os.path.join(base_dir, "docx"), "docx", lambda f, o: command_for_file(f, o)
    )
    # process_files(os.path.join(base_dir, "txt"), "txt", lambda f, o: command_for_file(f, o))
    process_files(
        os.path.join(base_dir, "xlsx"),
        "xlsx",
        lambda f, o: command_for_file(f, o, "xlsx"),
    )


if __name__ == "__main__":
    main()
