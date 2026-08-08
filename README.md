☸️ Guia Prático: Kustomize
O Kustomize é uma ferramenta nativa do Kubernetes para o gerenciamento de configurações declarativas. Ele permite customizar manifestos YAML brutos e sem templates, deixando o código original intacto. O Kustomize incentiva o reúso de código (DRY - Don't Repeat Yourself) através de herança estrutural e modularidade.

🏗️ Conceitos Principais
A arquitetura do Kustomize baseia-se fortemente na separação entre o que é comum a todos e o que é específico de cada ambiente.

Base: É um diretório contendo os manifestos originais e fundamentais (Deployments, Services, Ingress) que compõem a sua aplicação. A base não sabe nada sobre os ambientes em que vai rodar.

Overlay (Camada/Ambiente): É um diretório que "herda" as configurações da base e aplica modificações específicas (patches) em cima dela. Geralmente, você tem um overlay para cada ambiente (ex: dev, stage, prod).

kustomization.yaml: É o arquivo de controle lido pelo Kustomize. Todo diretório (seja base ou overlay) precisa ter um desses para dizer à ferramenta o que fazer.

📁 Estrutura de Diretórios Típica
Uma estrutura de pastas comum ao usar Kustomize segue este padrão:

Plaintext
meu-projeto/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── kustomization.yaml
└── overlays/
    ├── dev/
    │   ├── patch-replicas.yaml
    │   └── kustomization.yaml
    ├── stage/
    │   └── kustomization.yaml
    └── prod/
        ├── patch-resources.yaml
        └── kustomization.yaml
⚙️ Principais Campos do kustomization.yaml
Dentro do arquivo de controle, você utilizará diferentes chaves para montar seus manifestos:

1. Importação e Herança
resources: Lista de arquivos locais, diretórios (como a base) ou URLs remotas que serão carregados como a fundação do seu Kustomization.

components: Importa pacotes modulares (plugins) que injetam funcionalidades transversais (ex: configurações de segurança ou sidecars de observabilidade) de forma reutilizável.

2. Modificações (Patches)
patches: (ou patchesStrategicMerge) Utilizado para aplicar alterações pontuais a recursos específicos gerados pelos resources, como alterar limites de CPU, memória ou injetar variáveis de ambiente exclusivas.

3. Atalhos Nativos (Built-in Transformers)
Campos de nível superior que facilitam as mudanças mais comuns sem precisar escrever patches manuais:

namespace: Altera o namespace de todos os recursos.

namePrefix / nameSuffix: Adiciona prefixos e sufixos nos nomes dos recursos.

replicas: Modifica a contagem desejada de pods de um Deployment específico.

images: Altera o nome, a tag ou o digest das imagens de container.

commonLabels / commonAnnotations: Injeta labels e anotações globalmente em todos os manifestos.

4. Geradores
configMapGenerator: Gera ConfigMaps dinâmicos a partir de arquivos literais (ex: .env) com um hash acoplado ao nome, forçando o restart da aplicação caso o valor mude.

secretGenerator: Gera Secrets dinâmicos seguindo a mesma lógica dos ConfigMaps.

🚀 Comandos Úteis
O Kustomize já vem embutido na ferramenta de linha de comando padrão do Kubernetes (kubectl).

1. Visualizar o resultado final (Build)
Para ver como os YAMLs ficarão após todas as mesclagens e patches (sem aplicar no cluster):

Bash
# Entrar no diretório do ambiente desejado
kubectl kustomize ./overlays/prod

# Ou usando o binário standalone do kustomize
kustomize build ./overlays/prod
2. Aplicar no Cluster
Para aplicar o resultado final diretamente no seu cluster Kubernetes:

Bash
# Aplica a configuração do diretório atual (representado pelo ponto .)
kubectl apply -k .

# Ou aplicando a partir da raiz do projeto
kubectl apply -k overlays/prod
3. Deletar os Recursos
Para remover do cluster tudo o que foi gerado pelo arquivo kustomization:

Bash
kubectl delete -k .
Este documento serve como referência rápida. Para cenários avançados, consulte a documentação oficial do Kustomize e do Kubernetes.