from snips_nlu import SnipsNLUEngine

parser = SnipsNLUEngine.from_path('../model')

print(parser.parse('where can i find briget jones diary'))