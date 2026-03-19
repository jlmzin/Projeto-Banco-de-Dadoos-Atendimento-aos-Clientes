# 🗄️ Estrutura do Banco de Dados

## 📦 Módulos do Sistema

### 👤 Usuários
- usuario
- cliente
- atendente

### 📞 Atendimento
- atendimento
- prioridade
- status
- avaliacao

### 🏆 Gamificação
- pontuacao
- badge
- usuario_badge
- ranking_mensal
- meta_atendente

### 🎁 Loja de Recompensas
- recompensa
- resgate_recompensa

---

## 🔗 Relacionamentos Importantes

- Usuário → Cliente/Atendente (1:1)
- Cliente → Atendimento (1:N)
- Atendente → Atendimento (1:N)
- Atendimento → Avaliação (1:1)
- Usuário → Pontuação (1:1)
