
-- ==================================================================
--          INITIALIZATION SCRIPT FOR JOB PORTAL DATABASE
-- ==================================================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS companies;
DROP TABLE IF EXISTS users;     

-- -----------------------------------------------------------------
--                     TABLE DEFINITIONS
-- -----------------------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) CHECK (role IN ('candidate', 'recruiter', 'admin')),
    created_at TIMESTAMP DEFAULT NOW() 
);

CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    industry VARCHAR(255),
    location VARCHAR(255),
    key_contact_email VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE jobs (
    id SERIAL PRIMARY KEY,
    company_id INT REFERENCES companies(id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    employment_type VARCHAR(50) CHECK (employment_type IN ('full-time', 'part-time', 'contract', 'internship')),
    salary_range VARCHAR(100),
    requirements TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE applications (
    id SERIAL PRIMARY KEY,
    job_id INT NOT NULL REFERENCES jobs(id),
    user_id INT NOT NULL REFERENCES users(id),
    status VARCHAR(50) CHECK (status IN ('submitted', 'applied', 'under review', 'interview', 'offered', 'rejected')) DEFAULT 'submitted',
    created_at TIMESTAMP DEFAULT NOW()
);

-- -----------------------------------------------------------------
--                     INITIAL SAMPLE DATA INSERTION (COMPANIES & JOBS)
-- -----------------------------------------------------------------

INSERT INTO companies (name, description, industry, location, key_contact_email, website) 
VALUES
('Tessi', 'International Business Process Services (BPS)', 'BPS', 'France', 'hr@tessi.eu', 'https://www.tessi.eu'),
('DATAPROTECT', 'Cybersecurity company with offices in Casablanca, Paris, Abidjan, Dubai', 'Cybersecurity', 'Casablanca', 'hr@dataprotect.com', 'https://www.dataprotect.com'),
('Sofrecom', 'IT infrastructure & network management', 'IT Services', 'France', 'hr@sofrecom.com', 'https://www.sofrecom.com'),
('SMILE', 'Open-source integration & IT solutions', 'IT Services', 'Casablanca', 'hr@smile.fr', 'https://www.smile.eu');

INSERT INTO jobs (company_id, title, description, location, employment_type, salary_range, requirements)
VALUES
(1, 'Administrateur Réseaux', 'Surveillance et gestion de l’infrastructure réseau et sécurité de l’entreprise.', 'France', 'full-time', '40k-50k€', '3-5 ans expérience, BAC+3 à BAC+5 en informatique, compétences réseau, ITIL, Cloud, automatisation'),
(2, 'Administrateur IT', 'Fiabilité et sécurité de l’infrastructure informatique, support utilisateurs et gestion incidents.', 'Casablanca', 'full-time', '35k-45k€', 'Bac+2/3, expérience en administration systèmes et réseaux, français/anglais'),
(3, 'Technicien Systèmes et Réseaux', 'Supervision et exploitation des infrastructures systèmes et réseaux.', 'France', 'full-time', '45k-55k€', '4-5 ans expérience, Windows/Linux, Active Directory, VMWare, Azure, AWS, SCCM, Intune'),
(4, 'Administrateur Linux & Cloud', 'Déploiement, maintenance et intégration des systèmes Linux et cloud.', 'Casablanca', 'full-time', '30k-40k€', '1+ an expérience Linux, Ansible/Terraform, connaissances AWS, Cloud et virtualisation');