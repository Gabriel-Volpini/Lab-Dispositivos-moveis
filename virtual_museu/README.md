# Museu virtual

Um App desenvolvido com a motivação de incentivar as pessoas a conhecerem arte dentro dos limites da quarentena.

O aplicativo sorteia imagens de obras de arte da galeria do [museu de arte de Harvard](https://harvardartmuseums.org/) utilizando sua [api publica](https://github.com/harvardartmuseums/api-docs), você pode solicitar novas imagens clicando no botao direito inferior no qual será feito uma nova consulta e retornar outras imagens. Cada imagem possui um botão de favoritar para salvar as imagens que mais gostou de ver, este armazenamento é feito utilizando [SQLite](https://flutter.dev/docs/cookbook/persistence/sqlite)

O app possui em seu arquivo [HomePage.dart](/virtual_museu/lib/screen/HomePage.dart) na linha 22, a url de acesso a api, e nela deve ser inserido o seu token de autenticação para a api no lugar da frase "YOUR_API_KEY_HERE", leia a [documentação](https://github.com/harvardartmuseums/api-docs) para saber como obter sua key.

Este app foi feito utilizando a tecnologia [Flutter](https://flutter.dev/), Framework de desenvolvimento multiplataforma desenvolvido pela google. Este app tem como a realização do trabalho final da grade de Laboratório de dispositivos móveis, utilizando-se de gerenciamento de listas, consumir dados de api's externas e o gerenciamento de dados em bancos de dados interno para persistencia de dados.

<img src="/virtual_museu/lib/examples/demo1.gif" width="150" height="330"/>

Após favoritar suas imagens elas são salvas em um banco sqlite e podem ser exibidas e deletadas em uma tela de exclusiva para o gerenciamento dos favoritos.

<img src="/virtual_museu/lib/examples/demo2.gif" width="150" height="330"/>

## Problemas técnicos
A api não disponibiliza informações precisas sobre as imagens como dscrição, nome da obra ou autor, e acabou que foi necessário utilizar o identificador unico como meio de diferenciar as imagens entre si.

### Opiniões externas

- [Usuario 1](/virtual_museu/lib/reviews/Usuario1.md)
- [Usuario 2](/virtual_museu/lib/reviews/Usuario2.md)
- [Usuario 3 ](/virtual_museu/lib/reviews/Usuario3.md)
- [Usuario 4](/virtual_museu/lib/reviews/Usuario4.md)
- [Usuario 5](/virtual_museu/lib/reviews/Usuario5.md)

#### Clonar repositório
```
git clone https://github.com/Gabriel-Volpini/Lab-Dispositivos-moveis.git
```

#### Gerar APK
```
flutter build apk
```

## Tecnologias utilizadas

As principais aplicações utilizadas para o desenvolvimento desse app foram:

- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/guides/language)
- [Android Studio](https://developer.android.com/studio)
- [API do museu](https://github.com/harvardartmuseums/api-docs)
- [SQLite](https://flutter.dev/docs/cookbook/persistence/sqlite)

### Referências e sites de consulta
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Flutter online documentation](https://flutter.dev/docs)
- [Material Components widgets](https://flutter.dev/docs/development/ui/widgets/material)



