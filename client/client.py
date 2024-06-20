import requests

def estado(response):
    """ Obtiene el estado de la respuesta del servidor. """
    data = response.json()
    if 'estado' in data:
        return data['estado']
    return 0

def main():
    base_url = 'http://localhost:3000/api'
    print("\033[1;32m" + "="*50 + "\033[0m")
    print("\033[1;32mBienvenido al cliente CLI.\033[0m")
    print("\033[1;32m" + "="*50 + "\033[0m")
    correo = input("\033[94m* Introduce tu correo electrónico: \033[0m")
    clave = input("\033[94m* Introduce tu clave: \033[0m")
    
    # Intenta autenticar al usuario
    response = requests.get(f"{base_url}/login/{correo}")
    if estado(response) == 404:
        print("\033[91mUsuario no encontrado.\033[0m")
        return
    elif response.json().get('clave') != clave:
        print("\033[91mCredenciales incorrectas.\033[0m")
        return
    
    while True:
        print("\n\033[1;33m" + "="*50 + "\033[0m")
        print("\033[1;33mMenú de opciones:\033[0m")
        print("\033[1;33m" + "="*50 + "\033[0m")
        print("1. Ver información de una dirección de correo electrónico")
        print("2. Ver correos marcados como favoritos")
        print("3. Marcar correo como favorito")
        print("4. Terminar con la ejecución del cliente")
        opcion = input("\033[92m* Selecciona una opción: \033[0m")
        
        if opcion == '1':
            correo_consulta = input("\033[94m* Introduce el correo electrónico a consultar: \033[0m")
            resp = requests.get(f"{base_url}/informacion/{correo_consulta}")
            if estado(resp) == 404:
                print("\033[91mUsuario no encontrado.\033[0m")
            else:
                respuesta = resp.json()
                print(f"id: {respuesta['id']}")
                print(f"nombre: {respuesta['nombre']}")
                print(f"correo: {respuesta['correo']}")
                print(f"descripcion: {respuesta['descripcion']}")

        elif opcion == '2':
            resp = requests.get(f"{base_url}/favoritos/{correo}")
            if estado(resp) == 404:
                print("\033[91mNo se encontraron correos favoritos.\033[0m")
            else:
                data = resp.json()
                favoritos = data.get("favoritos", [])
                print(f"\033[96mFavoritos para {correo}:\033[0m")
                for favorito in favoritos:
                    print(f"ID de correo favorito: {favorito['id_correo_favorito']}")
                    info_correo = requests.get(f"{base_url}/info_correo/{favorito['id_correo_favorito']}").json()
                    print(f"Remitente: {info_correo['remitente_id']}")
                    print(f"Destinatario: {info_correo['destinatario_id']}")
                    print(f"Asunto: {info_correo['asunto']}\n")


        elif opcion == '3':
            try:
                id_correo_favorito = int(input("\033[94m* Introduce el ID del correo a marcar como favorito: \033[0m"))
            except ValueError:
                print("\033[91mEl ID debe ser un número entero.\033[0m")
                continue
            payload = {'correo': correo, 'clave': clave, 'id_correo_favorito': id_correo_favorito}
            resp = requests.post(f"{base_url}/marcarcorreo", json=payload)
            print(resp.json()['mensaje'])

        elif opcion == '4':
            print("\033[93m" + "="*50 + "\033[0m")
            print("\033[93mSaliendo del cliente...\033[0m")
            print("\033[93m" + "="*50 + "\033[0m")
            break
        else:
            print("\033[91mOpción no válida, intenta nuevamente.\033[0m")

if __name__ == "__main__":
    main()
