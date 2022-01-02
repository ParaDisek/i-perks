START TRANSACTION;
CREATE TABLE `perm_perks` (
  `id` int(11) NOT NULL,
  `identifier` varchar(25) NOT NULL,
  `perks` mediumtext NOT NULL,
  `perksexp` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
--
ALTER TABLE `perm_perks`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `perm_perks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;