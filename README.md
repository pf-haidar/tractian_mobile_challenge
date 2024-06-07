# Tractian Mobile Challenge

Aplicativo desenvolvido para o desafio de [código da Tractian](https://github.com/tractian/challenges/tree/main/mobile).

Consiste no desenvolvimento de um aplicativo contento uma TreeView para visualização localizações, assets e componentes de empresas. 

## O que eu melhoria se tivesse mais tempo?
- Com certeza teria investido mais tempo para deixar a interface mais parecida com o modelo disponibilizado no Figma.
- Teria melhorado o tratamento de erros Http para disponibilizar erros personalizados. Como utilizei o pacote Http no lugar do Dio, a escrita dos tratamentos dos erros deve ser mais trabalhada.

## Vídeo do Aplicativo



**Versão Mínima do OS**

- Android 30 (11)

## Desenvolvimento do aplicativo
### Requisitos para o ambiente de desenvolvimento

Software essesnciais para o desenvolvimento do aplicativo:

- [Flutter 3.22.2](https://docs.flutter.dev/development/tools/sdk/releases)
- [JDK 1.8.0_301](https://www.oracle.com/br/java/technologies/javase/javase8-archive-downloads.html) 
- [Android SDKs](https://developer.android.com/about/versions/12/setup-sdk) - API Level 31 (Recomendado instalar via [Android Studio](https://developer.android.com/studio))

### Instalação do ambiente de desenvolvimento

1. Instalar ferramentas necessárias para o desenvolvimento (Veja em [Requisitos para o ambiente de desenvolvimento](#requisitos-para-o-ambiente-de-desenvolvimento))
2. Baixar as dependências do projeto via Terminal

```sh
$ flutter pub get
```

## Bibliotecas utilizadas:

- [http](https://pub.dev/packages/http)
- [get](https://pub.dev/packages/get)