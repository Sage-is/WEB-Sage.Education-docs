import { Sponsor } from "@site/src/components/Sponsors/Sponsor";

export const SponsorList = () => {
	const sponsors = [
		{
			imgSrc: "/sponsors/sponsor.png",
			url: "https://sage.education",
			name: "Sage.is AI-UI",
			description:
				"On a mission to build the best open-source AI user interface.",
		},
	];

	return (
		<div
			style={{
				"--d": "flex",
				"--fw": "wrap",
				"--ai": "center",
				"--jc": "center",
				gap: "1.25rem",
			} as React.CSSProperties}
		>
			{sponsors.map((sponsor) => (
				<Sponsor sponsor={sponsor} />
			))}
		</div>
	);
};
