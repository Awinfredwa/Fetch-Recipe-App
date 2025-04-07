### Summary: Include screen shots or a video of your app highlighting its features

Main Page of Scrollable Recipe Grid View: 

<img width="508" alt="Screenshot 2025-04-06 at 6 38 36 PM" src="https://github.com/user-attachments/assets/f22ae395-6915-4eb7-a785-94603b0fa44e" />

Main Page Loading on Drag Down:

<img width="377" alt="Screenshot 2025-04-06 at 6 39 37 PM" src="https://github.com/user-attachments/assets/019ac2e2-14f0-4a06-8a87-ff0c6fc5ba84" />

Recipe Detail Page

<img width="508" alt="Screenshot 2025-04-06 at 6 38 56 PM" src="https://github.com/user-attachments/assets/c89cbfd8-fefd-4033-966e-86c8f43e50b8" />

Main Page on Malformed/Empty Data
<img width="508" alt="Screenshot 2025-04-06 at 6 41 42 PM" src="https://github.com/user-attachments/assets/e12d8bd0-a228-4411-b7e7-7474a687f101" />
<img width="464" alt="Screenshot 2025-04-06 at 6 42 12 PM" src="https://github.com/user-attachments/assets/be659a84-df9d-421d-9ccf-69c43f4add73" />

Deployed it on VisionOS for a Tiny Flex (Recipe App on Vision Pro is a Great Idea!)
<img width="911" alt="Screenshot 2025-04-06 at 7 02 30 PM" src="https://github.com/user-attachments/assets/1be07fdd-b2dd-47c1-a0dd-259412060c70" />


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I put a lot of care into structuring the project so everything is modular and easy to maintain and scale. I split the app into layers — views, widgets, models, view models, services, and utils, so each file has a clear role. Networking and image loading are fully async using Swift’s async/await, which keeps things modern, readable, and avoids callback clutter. For example, the RecipeService handles all data fetching, while the RecipeViewModel takes care of the state and business logic for the UI. This separation made it easier to test and debug, and would scale well if the app grew more complex.

Since third-party tools and URLCache weren’t allowed, I built a lightweight custom image cache using FileManager. It saves image data to the app’s cache directory, and reads it back if it already exists. I used the hash of the image URL as the file name for simplicity. The caching logic is encapsulated in an ImageCache utility, so views just call loadImage(from:) and don't worry about the rest. This helped keep image loading efficient and bandwidth friendly, while keeping the rest of the code clean.

I wrote tests for both recipe fetching and image caching. For the RecipeService, I tested normal, malformed, and empty API responses. For ImageCache, I tested saving an image to disk and reading it back, and verified that the cache file is actually created after the first load. I avoided overcomplicating the tests with mock sessions.  Instead, I focused on what matters: proving that caching works and that my network layer handles bad input safely. The project structure made this easy since logic was already separated from the UI.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent around 4 hours on this project. I started by setting up the basic project structure and building out the core views using SwiftUI, which took around an hour. Once the layout was working, I focused on getting the network and image loading logic clean and modular(another hour). After that, I spent an hour added caching with FileManager, then wrote a few unit tests to cover recipe fetching and image caching. I spent the last hour polishing the UI layout, setting up VisionOS deployment, and writing this README.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Since the project had a clear focus on concurrency, clean architecture, and avoiding third-party tools, I prioritized getting the structure right and keeping things easy to maintain. For image caching, I used a simple hash of the URL string for the filename, which is not the most robust solution in production, but fast and effective for a take home project like this. I also chose not to implement things like animations, dynamic layouts, or fancy design tweaks, since I assumed the main goal was to evaluate code quality and engineering decisions, not visual polish.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part is probably the visual design. The layout is functional and responsive, but pretty minimal. I didn’t spend much time finetuning spacing, colors, or adding custom styling. That said, I don’t think that was the focus here. I made sure the structure was clean, the logic was efficient, and the experience was solid overall.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
