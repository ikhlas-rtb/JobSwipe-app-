import React, { useEffect, useState } from "react";

function App() {
    const [jobs, setJobs] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetch("http://localhost:5000/jobs")
            .then(res => res.json())
            .then(data => {
                setJobs(data);
                setLoading(false);
            })
            .catch(err => {
                console.error("Erreur:", err);
                setLoading(false);
            });
    }, []);

    return (
        <div className="p-10 space-y-6">
            <h1 className="text-3xl font-bold">JobSwipe</h1>
            <p className="text-gray-600">Bienvenue ! Voici des jobs disponibles 👇</p>

            {loading && <p>Chargement...</p>}

            <div className="space-y-4">
                {jobs.map(job => (
                    <div key={job.id} className="p-4 border rounded-lg shadow-sm">
                        <h2 className="text-xl font-semibold">{job.title}</h2>
                        <p className="text-sm text-gray-500">
                            Skills: {job.skills.join(", ")}
                        </p>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default App;
