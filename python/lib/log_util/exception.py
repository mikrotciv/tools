"""Log utility exceptions"""
from custom_exception import CustomException

class LogException(CustomException):
    """Log exception"""

    def __init__(self, message: str=None):
        self.message = message if message is not None else "Exception raised while running logger"
        super().__init__(self.message)
