-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 14 juin 2024 à 22:33
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `db_score`
--

-- --------------------------------------------------------

--
-- Structure de la table `buts`
--

CREATE TABLE `buts` (
  `id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL,
  `joueur_id` int(11) NOT NULL,
  `minute_but` time NOT NULL,
  `equipe_marq_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `buts`
--

INSERT INTO `buts` (`id`, `match_id`, `joueur_id`, `minute_but`, `equipe_marq_id`) VALUES
(1, 1, 2, '00:00:00', 1),
(2, 2, 1, '00:00:00', 2);

-- --------------------------------------------------------

--
-- Structure de la table `equipes`
--

CREATE TABLE `equipes` (
  `id` int(11) NOT NULL,
  `nom_equipe` varchar(255) NOT NULL,
  `ville_equipe` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `equipes`
--

INSERT INTO `equipes` (`id`, `nom_equipe`, `ville_equipe`) VALUES
(1, 'AS-DRAGON', 'ABOMEY-CALAVI'),
(2, 'AS-LEOPARD', 'BOHICON'),
(3, 'AS-LION', 'ALLADA'),
(4, 'AS-ELEPHANT', 'DASSA-ZOUME');

-- --------------------------------------------------------

--
-- Structure de la table `joueurs`
--

CREATE TABLE `joueurs` (
  `id` int(11) NOT NULL,
  `nom_joueur` varchar(255) NOT NULL,
  `prenom_joueur` varchar(255) NOT NULL,
  `date_naissance` date NOT NULL,
  `poste_joueur` varchar(255) NOT NULL,
  `equipe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `joueurs`
--

INSERT INTO `joueurs` (`id`, `nom_joueur`, `prenom_joueur`, `date_naissance`, `poste_joueur`, `equipe_id`) VALUES
(1, 'FANDE', 'Jean', '2014-06-02', 'Attaquant', 1),
(2, 'PADE', 'Jacques', '2013-07-10', 'Lateral Gauche', 2),
(3, 'ZOPA', 'Tony', '2013-03-12', 'Defenseur', 3),
(4, 'ABADJA', 'Justin', '2012-12-11', 'Milieu', 1),
(5, 'ADJE', 'Theophile', '2012-04-02', 'Defenseur', 1),
(6, 'ABADJA', 'Justin', '2013-04-24', 'Milieu', 1),
(7, 'ADJE', 'Theophile', '2012-05-08', 'Defenseur', 1);

-- --------------------------------------------------------

--
-- Structure de la table `matchs`
--

CREATE TABLE `matchs` (
  `id` int(11) NOT NULL,
  `date_match` date NOT NULL,
  `equipe_dom_id` int(11) DEFAULT NULL,
  `equipe_visit_id` int(11) DEFAULT NULL,
  `score_dom` int(11) DEFAULT NULL,
  `score_visit` int(11) DEFAULT NULL,
  `stade` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `matchs`
--

INSERT INTO `matchs` (`id`, `date_match`, `equipe_dom_id`, `equipe_visit_id`, `score_dom`, `score_visit`, `stade`) VALUES
(1, '2024-01-13', 1, 2, 3, 2, 'SO Abomey'),
(2, '2024-01-14', 2, 1, 2, 1, 'SO Parakou'),
(5, '2024-06-03', NULL, NULL, 2, 1, 'Stade Charles de Gaulle Porto-Novo');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `buts`
--
ALTER TABLE `buts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `equipes`
--
ALTER TABLE `equipes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `joueurs`
--
ALTER TABLE `joueurs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `matchs`
--
ALTER TABLE `matchs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `buts`
--
ALTER TABLE `buts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `equipes`
--
ALTER TABLE `equipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `joueurs`
--
ALTER TABLE `joueurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `matchs`
--
ALTER TABLE `matchs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
