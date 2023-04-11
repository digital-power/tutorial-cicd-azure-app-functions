import logging

import azure.functions as func
from mylib.package_01 import hello
from mylib.package_02 import bye


def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')
            hello_str = hello(name=name)

            logging.info(hello_str)

            bye_str = bye(name=name)
            logging.info(bye_str)

    if name:

        return func.HttpResponse(f'Hello, {name}. This HTTP triggered function executed successfully.')
    else:
        return func.HttpResponse(
             'This HTTP triggered function executed successfully. Pass a name in the query string or in the request'
             ' body for a personalized response.',
             status_code=200
        )
