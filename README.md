# CODESYS Library Repository

Container Docker para publicar bibliotecas CODESYS como arquivos estaticos no Render.

## Estrutura

Coloque os arquivos dentro de `Libraries` seguindo o formato:

```text
Libraries/<vendor>/<lib>/<version>/<file>
```

Coloque os devices dentro de `Devices` seguindo o formato usado pelo repositorio de devices:

```text
Devices/<vendor-id>/<device-id>/<version>/<file>
```

Exemplo:

```text
Libraries/My_Test/Test_Download/1.0.0.0/Test_Download.compiled-library
```

Depois do deploy, a URL fica:

```text
https://<seu-servico>.onrender.com/Libs/My_Test/Test_Download/1.0.0.0/Test_Download.compiled-library
```

Para devices:

```text
https://<seu-servico>.onrender.com/Devices/4096/1799%200001/1.3.0.3/device.xml
```

Cada pasta tambem recebe um arquivo `index` com uma lista simples das pastas e arquivos disponiveis naquele nivel, acessivel diretamente pela URL:

```text
https://<seu-servico>.onrender.com/index
https://<seu-servico>.onrender.com/Libs/index
https://<seu-servico>.onrender.com/Libs/My_Test/index
https://<seu-servico>.onrender.com/Libs/My_Test/Test_Download/index
https://<seu-servico>.onrender.com/Libs/My_Test/Test_Download/1.0.0.0/index
https://<seu-servico>.onrender.com/Devices/index
https://<seu-servico>.onrender.com/Devices/4096/index
https://<seu-servico>.onrender.com/Devices/4096/1799%200001/index
https://<seu-servico>.onrender.com/Devices/4096/1799%200001/1.3.0.3/index
```

Formato do `index`:

```text
1.0.0.0
```

## Deploy no Render

1. Suba este repositorio para o Git.
2. No Render, crie um novo **Web Service**.
3. Escolha **Docker** como runtime.
4. Aponte para este repositorio.
5. Use o `Dockerfile` da raiz.

O arquivo `render.yaml` tambem permite criar o servico via Blueprint.

Durante o build, o container remove os arquivos padrao do Nginx e publica somente o conteudo do repositorio.
O conteudo de `Libraries` e publicado dentro de `/Libs`.
O conteudo de `Devices` e publicado dentro de `/Devices`.

## Teste local

Para gerar os arquivos `index` localmente na pasta `Libraries`, rode:

```bash
./scripts/generate-indexes.sh
```

Ou informe a pasta explicitamente:

```bash
./scripts/generate-indexes.sh Libraries
```

```powershell
docker build -t codesys-library-repository .
docker run --rm -p 10000:10000 -e PORT=10000 codesys-library-repository
```

Abra:

```text
http://localhost:10000/Libs/My_Test/Test_Download/1.0.0.0/Test_Download.compiled-library
```
