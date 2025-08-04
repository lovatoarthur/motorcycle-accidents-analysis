import requests
import zipfile


def download_zip_file(url, output_path):
    """
    Downloads a ZIP file from the given URL and saves it to the specified output path.
    """

    try:
        response = requests.get(url)
        response.raise_for_status()

        with open(output_path, "wb") as file:
            file.write(response.content)

        return True

    except requests.exceptions.RequestException as e:
        print(f"Error downloading file: {e}")
        return False

    except Exception as e:
        print(f"An error occurred: {e}")
        return False


def get_url(year):
    """
    Returns the URL of the ZIP file for the given year.
    """
    return f"https://static.nhtsa.gov/nhtsa/downloads/FARS/{year}/National/FARS{year}NationalCSV.zip"


def unzip_and_delete_zip(zip_file_path, output_path):
    """
    Unzips the ZIP file and deletes it.
    """
    with zipfile.ZipFile(zip_file_path, "r") as zip_ref:
        zip_ref.extractall(output_path)

    # Delete the ZIP file
    import os

    os.remove(zip_file_path)


def run():
    """
    Downloads the ZIP file for each year from 1975 to 2023.
    """
    years = range(1975, 2024)

    for year in years:
        url = get_url(year)
        output_path = f"data/raw/{year}.zip"

        success = download_zip_file(url, output_path)
        if success:
            unzip_and_delete_zip(output_path, f"data/raw/{year}")
            print(f"Downloaded and unzipped FARS{year}NationalCSV.zip to {output_path}")
        else:
            print(f"Failed to download FARS{year}NationalCSV.zip")


if __name__ == "__main__":
    run()
