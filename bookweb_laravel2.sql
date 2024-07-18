-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 10, 2024 at 07:45 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookweb_laravel2`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `user_id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Words', NULL, '2024-04-26 06:09:50', '2024-04-26 06:10:04');

-- --------------------------------------------------------

--
-- Table structure for table `contributions`
--

CREATE TABLE `contributions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `faculty_coordinator_id` bigint(20) UNSIGNED NOT NULL,
  `semester_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `upload_file` text NOT NULL,
  `upload_image` text NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `popular` enum('1','0') DEFAULT '0',
  `comment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contributions`
--

INSERT INTO `contributions` (`id`, `user_id`, `faculty_coordinator_id`, `semester_id`, `category_id`, `name`, `content`, `upload_file`, `upload_image`, `thumbnail`, `status`, `popular`, `comment`, `created_at`, `updated_at`, `deleted_at`) VALUES
(14, '534387', 11, 2, 1, 'fefwefew', 'efwfewfew', 'uploads/file/Intellectual Property Issues in Software.docx', 'C:\\xampp\\tmp\\phpD7E9.tmp', 'uploads/image/image6.jpg', 'pending', '0', NULL, '2024-05-02 18:37:49', '2024-05-02 18:37:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `faculty__coordinators`
--

CREATE TABLE `faculty__coordinators` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `semester_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faculty__coordinators`
--

INSERT INTO `faculty__coordinators` (`id`, `name`, `description`, `user_id`, `semester_id`, `created_at`, `updated_at`) VALUES
(11, 'INFORMATION AND TECHNOLOGY', NULL, '384872', 2, '2024-05-02 09:57:48', '2024-05-02 09:57:48');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2019_08_19_000000_create_failed_jobs_table', 1),
(5, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(6, '2024_04_26_003507_create_sessions_table', 1),
(7, '2024_04_26_004842_create_permissions_table', 2),
(8, '2024_04_26_005041_create_roles_table', 3),
(9, '2024_04_26_005403_create_role_permission', 4),
(10, '2024_04_26_005701_add_users_table', 5),
(11, '2024_04_26_101437_add_code_to_roles', 6),
(12, '2024_04_26_104741_create_semesters_table', 7),
(13, '2024_04_26_125225_create_categories_table', 8),
(14, '2024_04_26_134149_create_faculty__coordinators_table', 9),
(15, '2024_04_28_074801_add_softdelete_to_users', 10),
(16, '2024_04_28_075119_add_softdelete_to_contributions', 11),
(17, '2024_04_28_095347_create_notifications_table', 12);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('00192ae2-eefc-4048-aa0c-5c9faf5b455d', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:30', '2024-04-29 20:21:55', '2024-04-30 08:58:30'),
('26775021-81e4-4b6e-96f6-ac64ef3eed3c', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 167652, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:42:49', '2024-05-02 04:42:49'),
('37723796-8afc-4c51-8f81-5f5c5b5ab74b', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 494759, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:50:35', '2024-05-02 04:50:35'),
('37837bb7-5d0a-4258-bf7e-7d86f4348dc3', 'App\\Notifications\\DatabaseStudentEdit', 'App\\Models\\User', 509373, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has updated post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-04-30 08:53:15', '2024-04-30 08:53:15'),
('4f777232-59eb-43ae-b69e-1c72a5932d89', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 167652, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:16:46', '2024-05-02 04:16:46'),
('5085f5e1-6ca5-4e73-a69b-d1a2ab8527c9', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 744165, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:52:16', '2024-05-02 04:52:16'),
('508fdd93-7827-4b17-ad51-5f71e4081141', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 509373, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 05:05:17', '2024-05-02 05:05:17'),
('5677582d-b4f8-4db2-9eb7-87b20c213fac', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 526023, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:13:27', '2024-05-02 04:13:27'),
('57261191-d6e9-4e3a-b030-4d5bb1f4027a', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 574436, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:35:57', '2024-05-01 21:35:57'),
('58736d9f-d0c1-420b-adfb-d325699ae4e9', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:21', '2024-04-30 05:56:58', '2024-04-30 08:58:21'),
('5e3cb31e-acdd-41b3-a353-305a99416a0e', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 0, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:48:36', '2024-05-01 21:48:36'),
('5edcaf59-cb67-45b1-99fb-56d5461a523f', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:32', '2024-04-29 20:20:35', '2024-04-30 08:58:32'),
('60024e11-6892-4937-aabf-81653b23e516', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:20', '2024-04-30 05:58:20', '2024-04-30 08:58:20'),
('692a3eae-db0b-4c45-b7ec-06eead9cd94d', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:23', '2024-04-29 20:48:07', '2024-04-30 08:58:23'),
('697dfad3-c0b5-4086-893e-d85bbcd6cb4e', 'App\\Notifications\\DatabaseStudentAdd', 'App\\Models\\User', 509373, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has add new post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-05-02 03:26:26', '2024-05-02 03:26:26'),
('7044af6f-8dde-4e2f-beb1-16923c3ca38f', 'App\\Notifications\\DatabaseStudentAdd', 'App\\Models\\User', 509373, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has add new post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-05-01 19:12:37', '2024-05-01 19:12:37'),
('7baa0236-05ad-436a-99ae-613aa6fe81c7', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:19', '2024-04-30 08:55:40', '2024-04-30 08:58:19'),
('7ed35622-24c6-4fc2-8d50-c3c09432956b', 'App\\Notifications\\AdminsendCoordinatorDatabase', 'App\\Models\\User', 509373, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:26:55', '2024-05-01 21:26:55'),
('818096f4-6813-464f-b0fc-35f510e6ddf6', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', NULL, '2024-04-29 20:04:45', '2024-04-29 20:04:45'),
('89a684fb-d995-46d4-8bfd-149681be672a', 'App\\Notifications\\DatabaseStudentAdd', 'App\\Models\\User', 384872, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has add new post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-05-02 18:37:53', '2024-05-02 18:37:53'),
('8d1bb051-80d5-4ad0-873d-7701ede9fdb9', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 150281, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:48:51', '2024-05-01 21:48:51'),
('94b07593-4d29-4dc6-b50c-985bed56e50f', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 494759, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:06:21', '2024-05-02 04:06:21'),
('99d96796-d634-4016-bb2e-243fbd5c7f54', 'App\\Notifications\\DatabaseStudentDelete', 'App\\Models\\User', 509373, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has deleted post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-04-30 08:54:01', '2024-04-30 08:54:01'),
('9b072b1d-888d-44ac-8c15-f777e8be2dd6', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:29', '2024-04-29 20:22:12', '2024-04-30 08:58:29'),
('b34a1412-efc5-420c-80a7-1e4ee66cb9e6', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 574436, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 04:51:33', '2024-05-02 04:51:33'),
('b577e68c-14c7-442c-8b9f-428af818f344', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 339274, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 03:29:23', '2024-05-02 03:29:23'),
('c0509296-e846-4db4-b9e4-5b023926cdf9', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:22', '2024-04-30 05:55:26', '2024-04-30 08:58:22'),
('c2625d11-8397-4c37-82c8-6c75119e0c8f', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 0, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:41:37', '2024-05-01 21:41:37'),
('dd3546a4-0c03-4a1c-a1f7-920871da8c9a', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 0, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 03:30:33', '2024-05-02 03:30:33'),
('de49db96-685a-4a23-a378-51bcd1fa52d1', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 924754, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:42:56', '2024-05-01 21:42:56'),
('dfc86f33-9650-415d-93b5-07508b6a4327', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 150281, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:49:14', '2024-05-01 21:49:14'),
('e2022e58-588e-4ddd-b2e8-0a0f1069e13e', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:26', '2024-04-29 20:28:06', '2024-04-30 08:58:26'),
('e728c75e-9a70-4356-905c-6a8e669673c3', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:27', '2024-04-29 20:27:51', '2024-04-30 08:58:27'),
('eb26f75f-53eb-4132-9f30-e2fde8094d28', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 799932, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 03:30:45', '2024-05-02 03:30:45'),
('ec7d133c-4eda-4304-b982-b680a46c439c', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:31', '2024-04-29 20:21:30', '2024-04-30 08:58:31'),
('edb455f4-907f-4a7e-bfe5-93f3bf3d2dcf', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:28', '2024-04-29 20:26:52', '2024-04-30 08:58:28'),
('f0d9a128-eb87-4203-a854-cc7f6eadcaad', 'App\\Notifications\\DatabaseStudentAdd', 'App\\Models\\User', 509373, '{\"user_code\":\"STU\",\"user_id\":534387,\"user_name\":\"anhchinh has add new post to your system\",\"user_email\":\"anhchinh@gmail.com\",\"user_image\":\"profile-photos\\/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png\"}', NULL, '2024-05-01 05:26:15', '2024-05-01 05:26:15'),
('f0ed7bbf-c7e7-45a4-b254-1276a863fefe', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:24', '2024-04-29 20:43:53', '2024-04-30 08:58:24'),
('f48c56fb-0408-43fe-81f4-edb7f4934630', 'App\\Notifications\\AdminsendDatabase', 'App\\Models\\User', 509373, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-02 05:05:55', '2024-05-02 05:05:55'),
('f59d254f-ee83-44de-8fe4-560ceacb6ef9', 'App\\Notifications\\CoordinatorSendByDatabase', 'App\\Models\\User', 534387, '{\"user_code\":\"COO\",\"user_id\":509373,\"user_name\":\"anhquan has been comment and checked post in your system\",\"user_email\":\"anhquan@gmail.com\"}', '2024-04-30 08:58:25', '2024-04-29 20:35:01', '2024-04-30 08:58:25'),
('fc36f7ec-6d32-460b-8e06-f3ca761bd61a', 'App\\Notifications\\AdminsendCoordinatorDatabase', 'App\\Models\\User', 509373, '{\"user_code\":\"AD\",\"user_id\":210834,\"user_name\":\"anhthuan has something for you in faculty management\",\"user_email\":\"tqanhthuan@gmail.com\"}', NULL, '2024-05-01 21:28:56', '2024-05-01 21:28:56'),
('feda1b7d-3bc0-460e-b12d-36ba4ba47e4e', 'App\\Notifications\\DatabaseStudentAdd', 'App\\Models\\User', 898030, '{\"user_code\":\"STU\",\"user_id\":372410,\"user_name\":\"anhvuong has add new post to your system\",\"user_email\":\"anhvuong@gmail.com\",\"user_image\":\"profile-photos\\/SWc4wP9UalfLfC28tWnfEFbSdwMqymFvd9aQoR5v.png\"}', NULL, '2024-05-01 19:28:13', '2024-05-01 19:28:13');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('anhtai@gmail.com', '$2y$12$7U.8Gxh29miGoBOI2DwgDul1ZB1aS/nvilcEaXndS/EnIfzCzl0YS', '2024-05-01 19:39:00');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `slug`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Add permission', 'permission/add', NULL, '2024-04-26 02:56:28', '2024-04-26 02:56:28'),
(2, 'Delete Permission', 'permission/delete', NULL, '2024-04-26 02:56:41', '2024-04-26 02:56:41'),
(4, 'Edit Permission', 'permission/edit', NULL, '2024-04-26 02:57:27', '2024-04-26 02:57:27'),
(5, 'List Role', 'role/list', NULL, '2024-04-26 02:57:40', '2024-04-26 02:57:40'),
(6, 'Add Role', 'role/add', NULL, '2024-04-26 02:57:54', '2024-04-26 02:57:54'),
(7, 'Edit Role', 'role/edit', NULL, '2024-04-26 02:58:08', '2024-04-26 02:58:08'),
(8, 'Delete Role', 'role/delete', NULL, '2024-04-26 02:58:19', '2024-04-26 02:58:19'),
(9, 'List User', 'user/list', NULL, '2024-04-26 02:58:31', '2024-04-26 02:58:31'),
(10, 'Add User', 'user/add', NULL, '2024-04-26 02:58:52', '2024-04-26 02:58:52'),
(11, 'Edit User', 'user/edit', NULL, '2024-04-26 02:59:06', '2024-04-26 02:59:06'),
(12, 'Delete User', 'user/delete', NULL, '2024-04-26 02:59:17', '2024-04-26 02:59:17'),
(13, 'Add Semester', 'semester/add', NULL, '2024-04-29 21:11:13', '2024-04-29 21:11:13'),
(14, 'Edit Semester', 'semester/edit', NULL, '2024-04-29 21:11:25', '2024-04-29 21:11:25'),
(15, 'Delete Semester', 'semester/delete', NULL, '2024-04-29 21:11:31', '2024-04-29 21:11:31'),
(16, 'Add Category', 'category/add', NULL, '2024-04-29 21:11:43', '2024-04-29 21:11:43'),
(17, 'Edit Category', 'category/edit', NULL, '2024-04-29 21:11:53', '2024-04-29 21:11:53'),
(18, 'Delete Category', 'category/delete', NULL, '2024-04-29 21:12:03', '2024-04-29 21:12:03'),
(19, 'List Faculty', 'faculty/list', NULL, '2024-04-29 21:47:15', '2024-04-29 21:47:15'),
(20, 'Add Faculty', 'faculty/add', NULL, '2024-04-29 21:47:26', '2024-04-29 21:47:26'),
(21, 'Edit Faculty', 'faculty/edit', NULL, '2024-04-29 21:47:41', '2024-04-29 21:47:50'),
(22, 'Delete Faculty', 'faculty/delete', NULL, '2024-04-29 21:48:02', '2024-04-29 21:48:02'),
(23, 'List Post', 'post/list', NULL, '2024-04-29 21:55:55', '2024-04-29 21:55:55'),
(24, 'Edit Post', 'post/edit', NULL, '2024-04-29 21:56:10', '2024-04-29 21:56:10'),
(25, 'Show Class', 'class/show', NULL, '2024-04-29 22:03:54', '2024-04-29 22:03:54'),
(26, 'List Contribution', 'class/contributionlist', NULL, '2024-04-29 22:04:23', '2024-04-29 22:07:56'),
(27, 'Add Contribution', 'class/contributionadd', NULL, '2024-04-29 22:05:07', '2024-04-29 22:05:07'),
(28, 'Edit Contribution', 'class/contributionedit', NULL, '2024-04-29 22:05:21', '2024-04-29 22:05:21'),
(29, 'Delete Contribution', 'class/contributiondelete', NULL, '2024-04-29 22:05:33', '2024-04-29 22:05:33'),
(30, 'Student History', 'history/historylist', NULL, '2024-04-29 22:09:39', '2024-04-29 22:09:39'),
(31, 'List Manger', 'allpost/list', NULL, '2024-04-30 04:08:17', '2024-04-30 04:08:17');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `code`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'AD', 'ADMIN', 'Manage all system', '2024-04-26 03:16:25', '2024-04-26 03:16:25'),
(2, 'COO', 'COORDINATOR', 'Manage Faculty and student\'s contribution', '2024-04-26 03:20:43', '2024-04-26 07:15:12'),
(4, 'MA', 'MARKETING MANAGER', NULL, '2024-04-26 03:22:42', '2024-04-26 03:22:42'),
(5, 'STU', 'STUDENT', NULL, '2024-04-26 03:22:54', '2024-04-26 03:22:54'),
(6, 'GU', 'GUEST', NULL, '2024-04-26 03:23:03', '2024-04-26 03:23:03');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission`
--

CREATE TABLE `role_permission` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_permission`
--

INSERT INTO `role_permission` (`id`, `role_id`, `permission_id`, `created_at`, `updated_at`) VALUES
(4, 1, 5, NULL, NULL),
(6, 1, 7, NULL, NULL),
(8, 1, 9, NULL, NULL),
(9, 1, 10, NULL, NULL),
(10, 1, 11, NULL, NULL),
(11, 1, 12, NULL, NULL),
(12, 1, 1, NULL, NULL),
(13, 1, 2, NULL, NULL),
(14, 1, 4, NULL, NULL),
(15, 1, 6, NULL, NULL),
(16, 1, 8, NULL, NULL),
(17, 1, 13, NULL, NULL),
(18, 1, 14, NULL, NULL),
(19, 1, 15, NULL, NULL),
(20, 1, 16, NULL, NULL),
(21, 1, 17, NULL, NULL),
(22, 1, 18, NULL, NULL),
(23, 1, 19, NULL, NULL),
(24, 1, 20, NULL, NULL),
(25, 1, 21, NULL, NULL),
(26, 1, 22, NULL, NULL),
(27, 2, 23, NULL, NULL),
(28, 2, 24, NULL, NULL),
(29, 5, 25, NULL, NULL),
(30, 5, 26, NULL, NULL),
(31, 5, 27, NULL, NULL),
(32, 5, 28, NULL, NULL),
(33, 5, 29, NULL, NULL),
(34, 5, 30, NULL, NULL),
(35, 4, 31, NULL, NULL),
(36, 2, 31, NULL, NULL),
(37, 5, 31, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `semesters`
--

CREATE TABLE `semesters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `semesters`
--

INSERT INTO `semesters` (`id`, `name`, `description`, `start_date`, `end_date`, `created_at`, `updated_at`) VALUES
(2, 'SUMMER 2024', NULL, '2024-06-20', '2024-09-22', '2024-04-26 11:23:45', '2024-04-26 11:23:45'),
(3, 'FALL 2024', NULL, '2024-04-04', '2022-04-28', '2024-04-26 11:24:13', '2024-05-01 17:34:42'),
(4, 'WINTER 2024', NULL, '2024-12-21', '2025-03-19', '2024-04-26 11:25:51', '2024-04-26 11:26:24');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('cwo9dYLBAXkyld3ldhdsv6zE6TzkjZL9cGFNcTBc', 384872, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiczQ5Ulh3eHVDUXVTU0R5WmtTUXk0bHg0WDU0cnRSbm5SVVU4NUl4MCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kYXNoYm9hcmQvc3R1ZGVudC9pbmZvLzE0Ijt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mzg0ODcyO30=', 1714700718),
('ITlixFK7lQhJ6twSdxVQa8G0EXRT6P9oNuLItXT2', 210834, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaU95Z2Y5dkdxY0Q5TktpUWFtR0Y1ejdzUkZ3ekNtZXZMVlZ4Rlp2RCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9mYWN1bHR5L2FkZCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjIxMDgzNDt9', 1714669068),
('MyLN3Cmn4Tto9I5urKCGfEkT4cwDk7TFJWbkh3RK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidkl2V2VMajBGaVFoQWt6UGczQU1heUhwU1dkTzA1RFBCQUUyaHN0biI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MjoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL21hbmFnZXIvYWxscG9zdC9saXN0Ijt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9tYW5hZ2VyL2FsbHBvc3QvbGlzdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1714700470),
('nWkbeVY2Hogzj1p8PlVu5oNk5JLsINQEpnn1KWz8', 534387, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQVVhUzQzSjNKdmJJTTVFYnJHSmVCM2d2U25zZEdvVEN1d2J5aUs0MyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9zdHVkZW50L2NsYXNzL3Nob3ciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo1MzQzODc7fQ==', 1714637038),
('pCGgNQKOYdGMjvQ48mtZqDQTUjbqrhTKaa6fKZax', 210834, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:125.0) Gecko/20100101 Firefox/125.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTXhnbEk0SER6ZXFROTBlczVjS09oa0tkWjBaUlJEVU1udUtCN2R6biI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi91c2VyL2xpc3QiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyMTA4MzQ7czozOiJ1cmwiO2E6MDp7fX0=', 1714625354),
('VxIIv2IeVk704FSlGG8NYmp5zNTagMBadyud7pbJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaHVhRzdhbVNxYTdNZnJrektGSzhsNWZJaXEwOUQwenlqVldudmdsMCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoxNzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9lbWFpbC92ZXJpZnkvMC80OTBlNGE4YWQ0ODRkNjI5MTJiNjE4YWI1MGM0MTc0YjI5YWUzNGE5P2V4cGlyZXM9MTcxNDY1MTQ0MiZzaWduYXR1cmU9NjE4OTcxNWRiYjI1MWI2MzJkZmFiNDEzNTNjNmI2NmJiYWM5NjY2ZDc4M2EyMjE2Mzk1M2Q5MWYyMmYwNDY1NCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1714648144);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `faculty_coordinator_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `faculty_coordinator_id`, `created_at`, `updated_at`) VALUES
(13, '534387', 11, '2024-05-02 18:37:49', '2024-05-02 18:37:49');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(255) NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `phone`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
('210834', 1, 'anhthuan', '0942135864', 'tqanhthuan@gmail.com', NULL, '$2y$12$ibEXP8ciJSa06D7aQt4l0.pFSavPeYy7ha5IrgmCVlFCV6OsdM77q', NULL, NULL, NULL, 'zfpfsy05c8kkFwCS0ao8Sx3n65LlFRlmqUznsf4BmR6xyqvF4T38Tnou10zN', NULL, 'profile-photos/Sg6fjFn2P6LwxfRr8PHx71YlZbs9Voi9KPZmlulA.jpg', '2024-04-25 17:42:27', '2024-04-30 04:46:19'),
('384872', 2, 'anhminh', '0897890897', 'anhminh@gmail.com', NULL, '$2y$12$1PzFW6jmKIhEMjClJE0QA.HEOoB2FVygneuG5bQqJH/qa3C8yVDA2', NULL, NULL, NULL, NULL, NULL, NULL, '2024-05-02 09:56:55', '2024-05-02 09:56:55'),
('509373', 2, 'anhquan', '0897890098', 'anhquan@gmail.com', NULL, '$2y$12$5XQivi8IydiNglFUI1Ol3eiuYx6cVZKzBy4v4nRdq.IVbQ03lQDyG', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-26 07:14:54', '2024-04-29 19:51:05'),
('534387', 5, 'anhchinh', '0897890897', 'anhchinh@gmail.com', NULL, '$2y$12$eUS/OzlXzQ77SJaRHSbZUOfQbSKpWSNG1pS11/lFWk6jRtr/ZG4U6', NULL, NULL, NULL, NULL, NULL, 'profile-photos/kaJ1Htk5uY1oRAe2VOOsrN78PIrnxS1GQyIBDqKC.png', '2024-04-27 03:39:48', '2024-04-30 04:48:25'),
('574436', 2, 'anhtri', '0897989789', 'anhtri@gmail.com', NULL, '$2y$12$RDfaiHsK9VfGbv04AGC2Ee9VtTMIFq.h4OcwT1q1P0NF8Z6yDf.K2', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-26 07:26:35', '2024-04-26 07:26:35'),
('744165', 2, 'anhphu', '0134576890', 'anhphu@gmail.com', NULL, '$2y$12$VrVXAa2/yFvFsr5YikTj0O8gkGppUZF8Kn97c5eQP91RKakvCnPQC', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-26 18:17:19', '2024-04-26 18:17:19'),
('898030', 2, 'anhthinh', '0789657899', 'anhthinh@gmail.com', NULL, '$2y$12$TJJcJWon1MMaskFqYddlj.F6SJ7GR9FfBJNsm7UsCQJXh.rB4yVQC', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-26 18:20:52', '2024-04-26 18:20:52'),
('904193', 4, 'anhvu', '0897896899', 'anhvu@gmail.com', NULL, '$2y$12$fk9Kyski76evqwr3kN88n.yD4zyiXbbUNenItB6L3fB8S.AOdhpTC', NULL, NULL, NULL, NULL, NULL, NULL, '2024-04-26 03:40:13', '2024-04-26 03:40:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contributions`
--
ALTER TABLE `contributions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contributions_user_id_foreign` (`user_id`),
  ADD KEY `faculty_coordinator_id` (`faculty_coordinator_id`),
  ADD KEY `semester_id` (`semester_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `faculty__coordinators`
--
ALTER TABLE `faculty__coordinators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faculty__coordinators_user_id_foreign` (`user_id`),
  ADD KEY `faculty__coordinators_semester_id_foreign` (`semester_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_permission_role_id_foreign` (`role_id`),
  ADD KEY `role_permission_permission_id_foreign` (`permission_id`);

--
-- Indexes for table `semesters`
--
ALTER TABLE `semesters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `students_user_id_foreign` (`user_id`),
  ADD KEY `faculty_coordinator_id` (`faculty_coordinator_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contributions`
--
ALTER TABLE `contributions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `faculty__coordinators`
--
ALTER TABLE `faculty__coordinators`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `role_permission`
--
ALTER TABLE `role_permission`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `semesters`
--
ALTER TABLE `semesters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contributions`
--
ALTER TABLE `contributions`
  ADD CONSTRAINT `contributions_ibfk_1` FOREIGN KEY (`faculty_coordinator_id`) REFERENCES `faculty__coordinators` (`id`),
  ADD CONSTRAINT `contributions_ibfk_2` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`),
  ADD CONSTRAINT `contributions_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `contributions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `faculty__coordinators`
--
ALTER TABLE `faculty__coordinators`
  ADD CONSTRAINT `faculty__coordinators_semester_id_foreign` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `faculty__coordinators_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_permission`
--
ALTER TABLE `role_permission`
  ADD CONSTRAINT `role_permission_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_permission_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`faculty_coordinator_id`) REFERENCES `faculty__coordinators` (`id`),
  ADD CONSTRAINT `students_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
