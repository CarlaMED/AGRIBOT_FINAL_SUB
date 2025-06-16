import os
from PIL import Image

#dataset path
input_dir = r"C:\FINALYEAR\Induvidual Research Project\AgriBotSim\archive\PlantVillageData\PlantVillage\train\leavesForCNN"
output_dir = os.path.join(os.path.dirname(input_dir), "resized_images")
os.makedirs(output_dir, exist_ok=True)

size = (224, 224)

# Debug print
print(f" Input Dir: {input_dir}")
print(f" Output Dir: {output_dir}\n")

for label_folder in os.listdir(input_dir):
    label_path = os.path.join(input_dir, label_folder)
    if not os.path.isdir(label_path):
        continue

    print(f"🔍 Checking folder: {label_folder}")
    count = 1

    for filename in os.listdir(label_path):
        if filename.lower().endswith((".png", ".jpg", ".jpeg")):
            img_path = os.path.join(label_path, filename)
            print(f" Found image: {img_path}")

            img = Image.open(img_path).resize(size)
            new_name = f"{label_folder}_{count:02}.png"
            img.save(os.path.join(output_dir, new_name))
            print(f"Saved as: {new_name}")
            count += 1

print("\n Done processing all images!")
