export const Sponsor = ({ sponsor }) => {
	return (
		<>
			<div style={{ "--mb": "0.5rem", "--d": "flex", "--fd": "column" } as React.CSSProperties}>
				<div
					style={{
						"--mb": "0.375rem",
						"--size": "0.6rem",
						"--weight": "700",
						"--c": "var(--text-muted)",
						"--td": "underline",
					} as React.CSSProperties}
				>
					<a href={sponsor.url} target="_blank">
						{sponsor.name}
					</a>
				</div>

				<a href={sponsor.url} target="_blank">
					<div
						style={{
							"--d": "flex",
							"--w": "8rem",
							"--w-md": "12rem",
							"--ai": "start",
							gap: "0.625rem",
						} as React.CSSProperties}
					>
						<div style={{ "--fb": "50%" } as React.CSSProperties}>
							<img
								style={{ "--radius": "0.75rem" } as React.CSSProperties}
								loading="lazy"
								alt={sponsor.name}
								src={sponsor.imgSrc}
							/>
						</div>

						<div style={{ "--d": "flex", "--fb": "50%" } as React.CSSProperties}>
							<div
								style={{
									"--line-clamp": "4",
									"--size": "0.6rem",
									"--weight": "700",
									"--c": "var(--text-muted)",
									"--td": "none",
								} as React.CSSProperties}
							>
								{sponsor.description}
							</div>
						</div>
					</div>
				</a>
			</div>
		</>
	);
};
