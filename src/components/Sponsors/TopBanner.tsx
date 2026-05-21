export const TopBanner = ({ items }) => {
	return (
		<div style={{ "--pb": "1rem" } as React.CSSProperties}>
			{items.map((item) => (
				<>
					<div style={{ "--mb": "0.5rem" } as React.CSSProperties}>
						<div
							style={{
								"--mb": "0.25rem",
								"--size": "0.75rem",
								"--weight": "600",
								"--c": "var(--text-muted)",
								"--td": "underline",
							} as React.CSSProperties}
						>
							Sponsored by {item.name}
						</div>

						<a href={item.url} target="_blank">
							<img
								style={{
									"--d": "none",
									"--d-md": "block",
									"--w": "100%",
									"--radius": "0.75rem",
								} as React.CSSProperties}
								loading="lazy"
								alt={item.name}
								src={item.imgSrc}
							/>

							<img
								style={{
									"--d": "block",
									"--d-md": "none",
									"--w": "100%",
									"--radius": "0.75rem",
								} as React.CSSProperties}
								loading="lazy"
								alt={item.name}
								src={item?.mobileImgSrc || item.imgSrc}
							/>
						</a>

						<div
							style={{
								"--mt": "0.25rem",
								"--line-clamp": "1",
								"--ta": "right",
								"--size": "0.75rem",
								"--weight": "600",
								"--c": "var(--text-muted)",
							} as React.CSSProperties}
						>
							{item.description}
						</div>
					</div>
				</>
			))}
		</div>
	);
};
