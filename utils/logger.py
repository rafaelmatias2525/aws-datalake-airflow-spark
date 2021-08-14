import logging

def get_logger():
        
    # Get the top-level logger object
    loggger = logging.getLogger()

    logging.basicConfig(
        format='%(asctime)s [%(levelname)-4s] %(message)s',
        level=logging.INFO,
        datefmt='%Y-%m-%d %H:%M:%S'
    )

    return loggger