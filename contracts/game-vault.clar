;; Title: GameVault Pro NFT Smart Contract

;; Revolutionary Gaming Asset Management Platform
;;
;; GameVault Pro transforms digital gaming into a profitable venture by bridging 
;; blockchain technology with competitive gameplay. This next-generation smart contract 
;; creates a unified ecosystem where gaming prowess translates directly into Bitcoin earnings, 
;; establishing the first truly decentralized play-to-earn infrastructure on Stacks Layer 2.
;;
;; Core Innovation:
;; - Tokenized Gaming Excellence: Every achievement becomes a tradeable digital asset
;; - Performance-Based Economics: Real-time Bitcoin rewards tied to skill and dedication  
;; - Cross-Game Compatibility: Universal scoring system spanning multiple game genres
;; - Transparent Merit System: Immutable leaderboards ensuring fair competition
;; - Instant Monetization: Direct conversion from gameplay achievements to cryptocurrency
;;
;; Built for the future of gaming where talent meets tangible rewards, GameVault Pro 
;; empowers players to transform their passion into sustainable income while maintaining 
;; full ownership of their digital accomplishments through blockchain-secured NFTs.

;; Define the NFT trait directly in this contract
(define-trait nft-trait (
  (get-last-token-id
    ()
    (response uint uint)
  )
  (get-token-uri
    (uint)
    (response (optional (string-ascii 256)) uint)
  )
  (get-owner
    (uint)
    (response (optional principal) uint)
  )
  (transfer
    (uint principal principal)
    (response bool uint)
  )
))

;; Constants & Error Codes

;; Error definitions
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-INVALID-PARAMETERS (err u101))
(define-constant ERR-NFT-NOT-FOUND (err u102))
(define-constant ERR-ALREADY-MINTED (err u103))
(define-constant ERR-INSUFFICIENT-FUNDS (err u104))
(define-constant ERR-TRANSFER-FAILED (err u105))
(define-constant ERR-REWARD-DISTRIBUTION-FAILED (err u106))
(define-constant ERR-INVALID-RARITY (err u107))
(define-constant ERR-INVALID-GAME-TYPE (err u108))
(define-constant ERR-INVALID-PLAYER (err u109))

;; Valid rarity types
(define-constant VALID-RARITIES (list "common" "rare" "epic" "legendary"))

;; Data Variables

;; Contract owner
(define-data-var contract-owner principal tx-sender)

;; NFT collection name
(define-data-var collection-name (string-ascii 32) "GameVault Pro Digital Assets")

;; Token counter to generate unique IDs
(define-data-var last-token-id uint u0)

;; Reward system parameters
(define-data-var total-reward-pool uint u0)
(define-data-var reward-per-point uint u10) ;; 10 sats per point as default

;; Data Maps

;; NFT metadata storage
(define-map nft-metadata
  { token-id: uint }
  {
    name: (string-ascii 50),
    description: (string-ascii 200),
    rarity: (string-ascii 9),
    game-type: (string-ascii 50),
    minted-at: uint,
  }
)

;; Leaderboard tracking
(define-map player-scores
  { player: principal }
  {
    total-score: uint,
    last-updated: uint,
    total-rewards-earned: uint,
  }
)

;; Non-Fungible Token Definition

;; Define the NFT asset
(define-non-fungible-token game-asset uint)

;; Private Helper Functions

;; Validate rarity type
(define-private (is-valid-rarity (rarity (string-ascii 9)))
  (is-some (index-of VALID-RARITIES rarity))
)

;; Validate game type
(define-private (is-valid-game-type (game-type (string-ascii 50)))
  (and
    (> (len game-type) u0)
    (<= (len game-type) u50)
  )
)

;; Validate principal (enhanced check)
(define-private (is-valid-principal (addr principal))
  (and
    (not (is-eq addr tx-sender))
    ;; Add additional principal validation if needed
    true
  )
)