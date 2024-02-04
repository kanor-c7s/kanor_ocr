# Remplace le nombre dans les balises <p n="Pxxx"> où "xxx" est un nombre
# et utilise increment_number pour remplacer par un nombre incrémenté.
# Sert à corriger les erreurs de numérotations des paragraphes

import re

class XmlModifier:
    def __init__(self):
        self.counter = 0

    def increment_number(self, match):
        self.counter += 1
        return f'<p n="P{self.counter}">'

    def modify_xml(self, xml_code):
        modified_xml = re.sub(r'<p n="P\d+">', self.increment_number, xml_code)
        return modified_xml

def read_xml_from_file(file_path):
    with open(file_path, "r") as file:
        xml_content = file.read()
    return xml_content

def write_xml_to_file(file_path, xml_content):
    with open(file_path, "w") as file:
        file.write(xml_content)

if __name__ == "__main__":
    source_file_path = "source.xml"
    output_file_path = "output.xml"

    # Lecture du contenu du fichier source.xml
    xml_content = read_xml_from_file(source_file_path)

    # Modification du XML
    modifier = XmlModifier()
    modified_xml_content = modifier.modify_xml(xml_content)

    # Écriture du résultat dans le fichier output.xml
    write_xml_to_file(output_file_path, modified_xml_content)

    print("Modification terminée. Résultat enregistré dans output.xml.")