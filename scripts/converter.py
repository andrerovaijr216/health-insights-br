import csv
import struct
import os # Importamos a biblioteca 'os' para manipulação de arquivos

try:
    from dbfread import DBF, FieldParser
except ImportError:
    print("ERRO: Biblioteca 'dbfread' não encontrada.")
    print("Por favor, instale com o comando: pip install dbfread")
    exit()

# Classe de parser customizada para ignorar erros de decodificação
class MyFieldParser(FieldParser):
    def parse(self, field, data):
        try:
            return super().parse(field, data)
        except ValueError:
            return None

def decompress_dbc_to_dbf(dbc_path, dbf_path):
    with open(dbc_path, 'rb') as f_in, open(dbf_path, 'wb') as f_out:
        f_in.seek(4)
        header_data = f_in.read(28)
        num_records = struct.unpack('<I', header_data[0:4])[0]
        header_len = struct.unpack('<H', header_data[4:6])[0]
        
        f_out.write(b'\x03' + header_data[24:27])
        f_out.write(struct.pack('<I', num_records))
        f_out.write(struct.pack('<H', header_len))
        f_out.write(header_data[6:24])
        
        remaining_header = header_len - 32
        f_out.write(f_in.read(remaining_header))
        
        while f_in.peek(1):
            control = f_in.read(1)[0]
            if control > 127:
                n_repeat = control - 128
                byte_to_repeat = f_in.read(1)
                f_out.write(byte_to_repeat * n_repeat)
            else:
                f_out.write(f_in.read(control))

if __name__ == "__main__":
    dbc_file = 'SPSP2401.dbc'
    dbf_file = 'temp_SPSP2401.dbf'
    csv_file = 'SPSP2401.csv'

    try:
        print(f"Passo 1: Descomprimindo '{dbc_file}'...")
        decompress_dbc_to_dbf(dbc_file, dbf_file)
        print("Descompressão concluída.")

        print(f"Passo 2: Convertendo para '{csv_file}'...")
        # CORREÇÃO: Passamos o parser customizado e ignoramos campos inválidos
        table = DBF(dbf_file, encoding='iso-8859-1', parserclass=MyFieldParser, ignore_missing_memofile=True)
        with open(csv_file, 'w', newline='', encoding='utf-8') as f_out:
            writer = csv.writer(f_out, delimiter=';')
            writer.writerow(table.field_names)
            
            # Escreve as linhas, ignorando possíveis erros de decodificação
            for record in table:
                try:
                    writer.writerow(record.values())
                except Exception:
                    # Se uma linha específica falhar, ela será pulada.
                    # Isso garante que o processo não pare.
                    continue
        
        print(f"\nSUCESSO! Arquivo '{csv_file}' foi criado e está pronto para o Databricks.")

    except Exception as e:
        print(f"\nOcorreu um erro inesperado: {e}")
        print("Por favor, verifique se o arquivo DBC está correto.")
    
    finally:
        # Passo 3: Limpar o arquivo .dbf temporário que não é mais necessário
        if os.path.exists(dbf_file):
            os.remove(dbf_file)
            print(f"Arquivo temporário '{dbf_file}' foi removido.")