"""Log builder"""
import logging

from log_util.exception import LogException

class LogBuilder():
    """Helps build logs"""

    def __init__(self, logger: logging.Logger):
        if not isinstance(logger, logging.Logger):
            raise LogException("Passed in logger is not an instance of Logger object")
        self.logger = logger
        self.format = "[%(levelname)-8s %(asctime)s]: %(message)s (at %(filename)s:%(lineno)d)"

    def build(self, custom_format: str=None, custom_level: int=logging.INFO,
            enable_console: bool=True,
            enable_file: bool=False, file_name: str=None) -> None:
        """Build logger"""
        log_format = logging.Formatter(self.format if custom_format is None else custom_format)

        # Setup console log
        if enable_console:
            console_log = logging.StreamHandler()
            console_log.setFormatter(log_format)
            self.logger.addHandler(console_log)

        # Setup file log
        if enable_file:
            file_log = logging.FileHandler(
                f"{self.logger.name}.log" if file_name is None else file_name
            )
            file_log.setFormatter(log_format)
            self.logger.addHandler(file_log)

        # Setup logging level
        self.logger.setLevel(custom_level)

        # Finished building logger
        self.logger.debug("Successfully build logger")
