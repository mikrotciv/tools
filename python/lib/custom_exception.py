"""Custom Exception base class"""

class CustomException(Exception):
    """Custom Exception"""

    def __init__(self, *args):
        super().__init__(args)
