{}{
	let audioCtx = null;
	let activeTrack = null;
	let buffer = null;
	let source = null;

	async function play(track) {
		if (audioCtx === null) {
			audioCtx = new AudioContext();
		}
		await download(track);
		if (activeTrack) {
			activeTrack.stop();
		}
		const source = audioCtx.createBufferSource();
		source.buffer = buffer;
		source.connect(audioCtx.destination);
		source.start();
		activeTrack = source;
	}

	async function download(track) {
		media = await fetch('/stream_media', {
			method: 'POST',
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(track),
		});
		buffer = await audioCtx.decodeAudioData(await media.arrayBuffer());
	}

	const filteredList = document.getElementById('filters') 
	fetch('/list_media',{ 
		headers: {
			"Content-Type": "application/json",
		}})
		.then(response => {
			if (!response.ok) {
				throw new Error(`HTTP error! status: ${response.status}`);
			}
			return response.json();
		})
		.then(mediaJson => {
			console.log(mediaJson);
			const mediaList = document.createElement('ul');
			mediaJson.forEach(track => {
				console.log(track.title);
				const trackListing = document.createElement('li');
				const trackCue = document.createElement('a');
				trackCue.innerText = track.title;
				trackCue.addEventListener('click', (event) => {
					event.preventDefault();
					play(track);
				});
				trackListing.appendChild(trackCue);
				mediaList.appendChild(trackListing);
			});
			filteredList.replaceChildren(mediaList);
		})
		.catch(e => { console.error('Error fetching media list:', e); });
}
