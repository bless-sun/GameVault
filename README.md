# GameVault Pro NFT Smart Contract

[![Clarity Version](https://img.shields.io/badge/Clarity-3.0-blue)](https://docs.stacks.co/clarity/)
[![Stacks](https://img.shields.io/badge/Stacks-Layer%202-orange)](https://www.stacks.co/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Tests](https://img.shields.io/badge/Tests-Vitest-yellow)](https://vitest.dev/)

## 🎮 Revolutionary Gaming Asset Management Platform

GameVault Pro transforms digital gaming into a profitable venture by bridging blockchain technology with competitive gameplay. This next-generation smart contract creates a unified ecosystem where gaming prowess translates directly into Bitcoin earnings, establishing the first truly decentralized play-to-earn infrastructure on Stacks Layer 2.

## 🌟 Core Innovation

- **🏆 Tokenized Gaming Excellence**: Every achievement becomes a tradeable digital asset
- **💰 Performance-Based Economics**: Real-time Bitcoin rewards tied to skill and dedication  
- **🎯 Cross-Game Compatibility**: Universal scoring system spanning multiple game genres
- **📊 Transparent Merit System**: Immutable leaderboards ensuring fair competition
- **⚡ Instant Monetization**: Direct conversion from gameplay achievements to cryptocurrency

Built for the future of gaming where talent meets tangible rewards, GameVault Pro empowers players to transform their passion into sustainable income while maintaining full ownership of their digital accomplishments through blockchain-secured NFTs.

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Installation](#-installation)
- [Usage](#-usage)
- [API Reference](#-api-reference)
- [Testing](#-testing)
- [Security](#-security)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### NFT Management

- **Mint Game Assets**: Create unique NFTs representing gaming achievements
- **Metadata Storage**: Rich metadata including rarity, game type, and timestamps
- **Secure Transfers**: Safe ownership transfers with validation
- **Trait Compliance**: Full implementation of standard NFT traits

### Reward System

- **Performance Tracking**: Real-time player score recording
- **Bitcoin Rewards**: Direct BTC distribution based on achievements
- **Reward Pool Management**: Configurable reward pools with administrative controls
- **Leaderboards**: Immutable player rankings and statistics

### Administrative Features

- **Ownership Transfer**: Secure contract ownership management
- **Pool Management**: Add funds to reward pools
- **Access Control**: Role-based permissions for critical functions

## 🏗️ Architecture

### Contract Structure

```
GameVault Pro Contract
├── NFT Core Functions
│   ├── mint-game-nft
│   ├── transfer
│   └── metadata management
├── Reward System
│   ├── record-player-score
│   ├── distribute-bitcoin-rewards
│   └── add-to-reward-pool
├── Read-Only Functions
│   ├── get-nft-metadata
│   ├── get-reward-pool-balance
│   └── trait implementations
└── Administrative Functions
    └── transfer-ownership
```

### Data Models

#### NFT Metadata

```clarity
{
  name: (string-ascii 50),
  description: (string-ascii 200),
  rarity: (string-ascii 9),
  game-type: (string-ascii 50),
  minted-at: uint
}
```

#### Player Scores

```clarity
{
  total-score: uint,
  last-updated: uint,
  total-rewards-earned: uint
}
```

### Rarity System

- **Common**: Base-level achievements
- **Rare**: Skilled performance markers
- **Epic**: Exceptional accomplishments
- **Legendary**: Elite-tier achievements

## 🚀 Installation

### Prerequisites

- [Clarinet](https://github.com/hirosystems/clarinet) v2.0+
- [Node.js](https://nodejs.org/) v18+
- [Git](https://git-scm.com/)

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/bless-sun/GameVault.git
   cd GameVault
   ```

2. **Install dependencies**

   ```bash
   npm install
   ```

3. **Verify installation**

   ```bash
   clarinet check
   ```

4. **Run tests**

   ```bash
   npm test
   ```

## 📖 Usage

### Basic Operations

#### Minting Game NFTs

```clarity
;; Mint a new game achievement NFT
(contract-call? .game-vault mint-game-nft 
  "Epic Sword Master" 
  "Achieved mastery in sword combat with 1000+ victories"
  "epic"
  "RPG Combat")
```

#### Recording Player Scores

```clarity
;; Record a player's game performance
(contract-call? .game-vault record-player-score 
  'ST1PLAYER123...
  u500) ;; 500 points
```

#### Distributing Rewards

```clarity
;; Distribute Bitcoin rewards to a player
(contract-call? .game-vault distribute-bitcoin-rewards 
  'ST1PLAYER123...)
```

### Advanced Usage

#### Managing Reward Pools

```clarity
;; Add funds to the reward pool (owner only)
(contract-call? .game-vault add-to-reward-pool u1000000) ;; 1M sats
```

#### Transferring NFTs

```clarity
;; Transfer an NFT to another player
(contract-call? .game-vault transfer 
  u1                    ;; token-id
  tx-sender            ;; sender
  'ST1RECIPIENT123...) ;; recipient
```

## 📚 API Reference

### Public Functions

#### `mint-game-nft`

Creates a new game achievement NFT.

**Parameters:**

- `name` (string-ascii 50): NFT name
- `description` (string-ascii 200): NFT description  
- `rarity` (string-ascii 9): Rarity level (common, rare, epic, legendary)
- `game-type` (string-ascii 50): Game category

**Returns:** `(response uint uint)` - Token ID on success

**Errors:**

- `ERR-NOT-AUTHORIZED` (u100): Caller not authorized
- `ERR-INVALID-PARAMETERS` (u101): Invalid input parameters
- `ERR-INVALID-RARITY` (u107): Invalid rarity type
- `ERR-INVALID-GAME-TYPE` (u108): Invalid game type

#### `record-player-score`

Records a player's performance score.

**Parameters:**

- `player` (principal): Player's address
- `score` (uint): Performance score (1-10000)

**Returns:** `(response uint uint)` - New total score

**Errors:**

- `ERR-NOT-AUTHORIZED` (u100): Only owner can call
- `ERR-INVALID-PLAYER` (u109): Invalid player address
- `ERR-INVALID-PARAMETERS` (u101): Invalid score

#### `distribute-bitcoin-rewards`

Distributes Bitcoin rewards to a player.

**Parameters:**

- `player` (principal): Player's address

**Returns:** `(response uint uint)` - Reward amount distributed

**Errors:**

- `ERR-NOT-AUTHORIZED` (u100): Only owner can call
- `ERR-INVALID-PLAYER` (u109): Invalid player address
- `ERR-NFT-NOT-FOUND` (u102): Player not found
- `ERR-INSUFFICIENT-FUNDS` (u104): Insufficient reward pool

### Read-Only Functions

#### `get-nft-metadata`

Retrieves NFT metadata by token ID.

**Parameters:** `token-id` (uint)
**Returns:** `(optional metadata)`

#### `get-reward-pool-balance`

Gets current reward pool balance.

**Returns:** `uint` - Current pool balance

#### `get-last-token-id`

Gets the last minted token ID.

**Returns:** `(response uint uint)`

### Error Codes

| Code | Constant | Description |
|------|----------|-------------|
| u100 | ERR-NOT-AUTHORIZED | Caller not authorized |
| u101 | ERR-INVALID-PARAMETERS | Invalid input parameters |
| u102 | ERR-NFT-NOT-FOUND | NFT or player not found |
| u103 | ERR-ALREADY-MINTED | NFT already exists |
| u104 | ERR-INSUFFICIENT-FUNDS | Insufficient funds |
| u105 | ERR-TRANSFER-FAILED | Transfer operation failed |
| u106 | ERR-REWARD-DISTRIBUTION-FAILED | Reward distribution failed |
| u107 | ERR-INVALID-RARITY | Invalid rarity type |
| u108 | ERR-INVALID-GAME-TYPE | Invalid game type |
| u109 | ERR-INVALID-PLAYER | Invalid player address |

## 🧪 Testing

The project uses Vitest with Clarinet SDK for comprehensive testing.

### Running Tests

```bash
# Run all tests
npm test

# Run tests with coverage
npm run test:report

# Watch mode for development
npm run test:watch

# Check contract syntax
clarinet check
```

### Test Structure

```
tests/
└── game-vault.test.ts    # Comprehensive contract tests
```

### Test Coverage

Our test suite covers:

- ✅ NFT minting and metadata
- ✅ Transfer functionality
- ✅ Score recording and validation
- ✅ Reward distribution logic
- ✅ Administrative functions
- ✅ Error handling and edge cases
- ✅ Access control mechanisms

## 🔒 Security

### Security Features

- **Access Control**: Role-based permissions for sensitive operations
- **Input Validation**: Comprehensive parameter validation
- **Overflow Protection**: Safe arithmetic operations
- **Transfer Safeguards**: Multi-layer transfer validation
- **Pool Management**: Controlled reward distribution

### Security Considerations

1. **Owner Privileges**: Contract owner has significant control
2. **Reward Pool**: Ensure adequate funding before distributions
3. **Player Validation**: Verify player addresses before operations
4. **Score Limits**: Reasonable bounds on score submissions

### Audit Status

⚠️ **This contract has not been formally audited.** Use in production environments at your own risk.

## 🛠️ Development

### Project Structure

```
GameVault/
├── contracts/
│   └── game-vault.clar           # Main contract
├── tests/
│   └── game-vault.test.ts        # Test suite
├── settings/
│   ├── Devnet.toml              # Development settings
│   ├── Testnet.toml             # Testnet configuration
│   └── Mainnet.toml             # Mainnet configuration
├── Clarinet.toml                # Project configuration
├── package.json                 # Dependencies
└── README.md                    # This file
```

### Development Workflow

1. **Make changes** to contract code
2. **Run syntax check**: `clarinet check`
3. **Run tests**: `npm test`
4. **Format code**: `clarinet fmt`
5. **Commit changes** with descriptive messages

### Deployment

```bash
# Deploy to testnet
clarinet deployments deploy --network=testnet

# Deploy to mainnet (use with caution)
clarinet deployments deploy --network=mainnet
```

## 🤝 Contributing

We welcome contributions to GameVault Pro! Please follow these guidelines:

### How to Contribute

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Make** your changes
4. **Add** tests for new functionality
5. **Ensure** all tests pass (`npm test`)
6. **Commit** your changes (`git commit -m 'Add amazing feature'`)
7. **Push** to the branch (`git push origin feature/amazing-feature`)
8. **Open** a Pull Request

### Code Standards

- Follow Clarity best practices
- Add comprehensive tests for new features
- Update documentation for API changes
- Use clear, descriptive commit messages

### Issues

Please use GitHub Issues to report bugs or request features. Include:

- Clear description of the issue
- Steps to reproduce (for bugs)
- Expected vs actual behavior
- Contract version and environment details

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Stacks Foundation** for the blockchain infrastructure
- **Clarinet Team** for development tools
- **Gaming Community** for inspiration and feedback
