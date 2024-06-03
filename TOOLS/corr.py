# Petit programme pour corriger la numérotation des paragraphes dans les balises <p n="Pxxx"> où "xxx" est un nombre.

import re
import os

class XmlModifier:
    def __init__(self):
        self.counter = 0

    def increment_number(self, match):
        self.counter += 1
        return f'<p n="P{self.counter}">'

    def modify_xml(self, xml_code):
        return re.sub(r'<p n="P\d+">', self.increment_number, xml_code)

def read_xml_from_file(file_path):
    with open(file_path, "r") as file:
        return file.read()

def write_xml_to_file(file_path, xml_content):
    with open(file_path, "w") as file:
        file.write(xml_content)

def get_source_file_path():
    while True:
        file_path = input("Entrez le chemin du fichier .xml à modifier (sinon 'source.xml'): ") or "source.xml"
        if file_path.endswith('.xml'):
            return file_path
        print("Le fichier doit être un .xml")

if __name__ == "__main__":
    source_file_path = get_source_file_path()
    output_file_path = "output.xml"

    xml_content = read_xml_from_file(source_file_path)
    modified_xml_content = XmlModifier().modify_xml(xml_content)
    write_xml_to_file(output_file_path, modified_xml_content)

    message = "Aucun changement apporté." if xml_content == modified_xml_content else "Modification terminée. Résultat enregistré dans output.xml."
    print(message)