# Index

# The Repo Formerly Known As "Dreambooth"

## <a name="vast-ai-setup"></a>  Vast.AI Instructions
- Sign up for [Vast.AI](https://vast.ai/)
- Add some funds (I typically add them in $10 increments)
- Navigate to the [Client - Create page](https://vast.ai/console/create/)
  - Select pytorch/pytorch as your docker image, and the buttons "Use Jupyter Lab Interface" and "Jupyter direct HTTPS"
  - ![img.png](readme-images/vast-ai-step1-select-docker-image.png)
- You will want to increase your disk space, and filter on GPU RAM (12gb checkpoint files + 4gb model file + regularization images + other stuff adds up fast)
  - I typically allocate 150GB
  - ![img.png](readme-images/vast-ai-step2-instance-filters.png)
  - Also good to check the Upload/Download speed for enough bandwidth so you don't spend all your money waiting for things to download.
- Select the instance you want, and click `Rent`, then head over to your [Instances](https://vast.ai/console/instances/) page and click `Open`
  - ![img.png](readme-images/vast-ai-step3-instances.png)
  - You will get an unsafe certificate warning. Click past the warning or install the [Vast cert](https://vast.ai/static/jvastai_root.cer).
- Click `Notebook -> Python 3` (You can do this next step a number of ways, but I typically do this)
  - ![img.png](readme-images/vast-ai-step4-get-repo.png)
- Clone Joe's repo with this command
  - `!git clone https://github.com/JoePenna/Dreambooth-Stable-Diffusion.git`
  - Click `run`
  - ![img.png](readme-images/vast-ai-step5-clone-repo.png)
- Navigate into the new `Dreambooth-Stable-Diffusion` directory on the left and open the `dreambooth_runpod_joepenna.ipynb` file
  - ![img.png](readme-images/vast-ai-step6-open-notebook.png)
- Follow the instructions in the workbook and start training

# <a name="text-vs-dreamb"></a>  Textual Inversion vs. Dreambooth
The majority of the code in this repo was written by Rinon Gal et. al, the authors of the Textual Inversion research paper. Though a few ideas about regularization images and prior loss preservation (ideas from "Dreambooth") were added in, out of respect to both the MIT team and the Google researchers, I'm renaming this fork to:
*"The Repo Formerly Known As "Dreambooth""*.

For an alternate implementation , please see ["Alternate Option"](#hugging-face-diffusers) below.


# <a name="using-the-generated-model"></a> Using the generated model
The `ground truth` (real picture, caution: very beautiful woman)
<br><img src="https://user-images.githubusercontent.com/100188076/192403948-8d1d0e50-3e9f-495f-b8ba-1bcb6b536fc8.png" width="200">

Same prompt for all of these images below:

| `sks person` | `woman person` | `Natalie Portman person` | `Kate Mara person` |
| ----- | ------- | ----------------- | ----------- |
| <img src="https://user-images.githubusercontent.com/100188076/192403506-ab96c652-f7d0-47b0-98fa-267defa1e511.png" width="200"> | <img src="https://user-images.githubusercontent.com/100188076/192403491-cb258777-5091-4492-a6cc-82305fa729f4.png" width="200"> | <img src="https://user-images.githubusercontent.com/100188076/192403437-f9a93720-d41c-4334-8901-fa2d2a10fe36.png" width="200"> | <img src="https://user-images.githubusercontent.com/100188076/192403461-1f6972d9-64d0-46b0-b2ed-737e47aae31e.png" width="200"> |   

# <a name="debugging-your-results"></a> Debugging your results
### ❗❗ THE NUMBER ONE MISTAKE PEOPLE MAKE ❗❗

**Prompting with just your token. ie "joepenna" instead of "joepenna person"**


If you trained with `joepenna` under the class `person`, the model should only know your face as:

```
joepenna person
```

Example Prompts:

🚫 Incorrect (missing `person` following `joepenna`)
```
portrait photograph of joepenna 35mm film vintage glass
```

✅ This is right (`person` is included after `joepenna`)
```
portrait photograph of joepenna person 35mm film vintage glass
```

You might sometimes get someone who kinda looks like you with joepenna (especially if you trained for too many steps), but that's only because this current iteration of Dreambooth overtrains that token so much that it bleeds into that token.

