# GitProfile
    GitProfile é um aplicativo iOS que permite buscar perfis do GitHub e visualizar seus repositórios públicos. O aplicativo exibe informações como nome do usuário, linguagem utilizada nos repositórios e avatar do perfil.

# Funcionalidades
    Busca de usuários do GitHub: Pesquise por usuários do GitHub utilizando seus nomes de usuário.
    Listagem de repositórios: Visualize os repositórios públicos do usuário buscado.
    Exibição do avatar do perfil: O avatar do perfil é carregado e exibido utilizando a biblioteca Kingfisher.
    Consumo da API do GitHub: Integração com a API do GitHub para buscar informações de usuários e repositórios.
    Interface em ViewCode: A interface do aplicativo foi construída programaticamente utilizando ViewCode.

# Tecnologias Utilizadas
    Swift 5: Linguagem de programação utilizada para o desenvolvimento do aplicativo.
    UIKit: Framework utilizado para construir a interface do usuário.

# Estrutura MVVM

    A estrutura MVVM (Model-View-ViewModel) foi adotada neste projeto por ser a forma mais eficaz de gerenciar as responsabilidades de cada componente. Essa abordagem permite uma maior     organização do código. Como resultado, facilita a manutenção e a escalabilidade do projeto.


# Dependências
    As dependências do projeto foram gerenciadas com CocoaPods. As principais bibliotecas utilizadas são:
    Alamofire: Para realizar requisições HTTP de forma simplificada.
    Kingfisher: Para carregar e cachear imagens de forma eficiente.
